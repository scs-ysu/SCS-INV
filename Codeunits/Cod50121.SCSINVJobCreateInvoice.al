codeunit 50121 "SCSINVJob Create Invoice"
{

    SingleInstance = true;
    trigger OnRun()
    begin

    end;

    var

        TxtLineStillAllocatedToAutoTask: TextConst DEU = 'Projekt %1, Aufgabe %2:  Zeile %3 (%4) ist noch der "Dummy-Aufgabe" zugeordnet und muss manuell einer anderen Aufgabe zugeordnet werden .', ENU = 'Job %1, task %2: Line %3 (%4) is still allocated to the Auto-Created Job-Task and must be allocated to a "real" task manually.';

        myInt: Integer;
        CompanyInfo: Record "Company Information";
        gPerformanceDateFrom: Date;
        gPerformanceDateTo: Date;
        gCustomer: Record Customer;
        gOldBTCustNo: Code[20];
        gBreakLevel: Option "Per Customer","Per Job","Per Job Task";
        gJob: Record Job;

        gTempJobPlanningLine: Record "Job Planning Line" temporary;

        gJobCreateInv: Codeunit "Job Create-Invoice";

        gTempoSetup: Record "SCSJIFJIRA/Tempo-Setup";
        gJobTask: Record "Job Task";

    // Table 27 "Sales Line"
    //handle  OnDelete(): Changed implementation of deletion of job planning line invoices
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure SubToOnAfterDeleteEventOnSalesLineEvt(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        JobCreateInvoice: Codeunit "Job Create-Invoice";
    begin
        IF Rec."Job Contract Entry No." = 0 then
            JobCreateInvoice.DeleteSalesLine(Rec);
    end;

    //Codeunit 1002 "Job Create-Invoice"
    //handle modifications from function CreateSalesInvoiceLines
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnCreateSalesInvoiceLinesOnBeforeTestJob', '', false, false)]
    local procedure SubscribeToOnOnCreateSalesInvoiceLinesOnBeforeTestJobEvt(VAR Job: Record Job)
    begin
        GetTempoSetup(Job."Bill-to Customer No.");
        //gPerformanceDateFrom := 31129999D; //++ysu
        gPerformanceDateFrom := 99991231D; //++ysu
        gPerformanceDateTo := 0D;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnCreateSalesInvoiceLinesOnBeforeCreateSalesLine', '', False, false)]
    local procedure SubscribeToOnCreateSalesInvoiceLinesOnBeforeCreateSalesLineEvt(VAR JobPlanningLine: Record "Job Planning Line"; SalesHeader: Record "Sales Header"; SalesHeader2: Record "Sales Header"; NewInvoice: Boolean; VAR NoOfSalesLinesCreated: Integer)
    begin
        IF JobPlanningLine."Planning Date" < gPerformanceDateFrom THEN
            gPerformanceDateFrom := JobPlanningLine."Planning Date";

        IF JobPlanningLine."Planning Date" > gPerformanceDateTo THEN
            gPerformanceDateTo := JobPlanningLine."Planning Date";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnAfterCreateSalesInvoiceLines', '', false, false)]
    local procedure SubscribeToOnAfterCreateSalesInvoiceLinesEvt(SalesHeader: Record "Sales Header"; NewInvoice: Boolean)
    begin
        SalesHeader."Performance Date From" := gPerformanceDateFrom;
        SalesHeader."Performance Date To" := gPerformanceDateTo;
        SalesHeader."Invoice Header Text" := STRSUBSTNO(gCustomer."Inv. Header Templ.", SalesHeader."Performance Date From", SalesHeader."Performance Date To");
        SalesHeader.MODIFY;
        // to do uncomment
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnCreateSalesInvoiceJobTaskTestJob', '', false, false)]
    local procedure SubcribeToOnCreateSalesInvoiceJobTaskTestJobEvt(VAR Job: Record Job)
    begin
        gJob := Job;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeCreateNewInvoice', '', false, false)]
    local procedure SubcribeToOnBeforeCreateNewInvoiceEvt(VAR JobTask: Record "Job Task"; InvoicePerTask: Boolean; VAR OldJobNo: Code[20]; VAR OldJobTaskNo: Code[20]; LastJobTask: Boolean; VAR NewInvoice: Boolean; VAR IsHandled: Boolean)
    Var
        RepJobCreateInvoice: Report "SCSINVJob Create Sales Invoice";
    begin
        if LastJobTask then
            NewInvoice := true
        else begin
            if OldJobNo <> '' then begin
                // gBreakLevel := RepJobCreateInvoice.SetBreakLevel();
                case gBreakLevel of
                    gBreakLevel::"Per Customer":
                        NewInvoice := gOldBTCustNo <> gJob."Bill-to Customer No.";

                    gBreakLevel::"Per Job":
                        NewInvoice := OldJobNo <> JobTask."Job No.";

                    gBreakLevel::"Per Job Task":
                        NewInvoice := (OldJobNo <> JobTask."Job No.") or (OldJobTaskNo <> JobTask."Job Task No.");
                end;

            end;

            gJob.Get(JobTask."Job No.");
            gOldBTCustNo := gJob."Bill-to Customer No.";
            OldJobNo := JobTask."Job No.";
            OldJobTaskNo := JobTask."Job Task No.";
        end;
        if not gTempJobPlanningLine.Find('-') then begin
            NewInvoice := false;
            gTempJobPlanningLine.DeleteAll();
        end;

        if NewInvoice then
            IsHandled := false
        else
            IsHandled := true;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnCreateSalesInvoiceJobTaskOnBeforeCreateSalesLine', '', false, false)]
    local procedure SubcriberToOnCreateSalesInvoiceJobTaskOnBeforeCreateSalesLineEvt(VAR JobPlanningLine: Record "Job Planning Line"; SalesHeader: Record "Sales Header"; SalesHeader2: Record "Sales Header"; VAR NoOfSalesLinesCreated: Integer)
    begin
        IF JobPlanningLine."Planning Date" < gPerformanceDateFrom THEN
            gPerformanceDateFrom := JobPlanningLine."Planning Date";

        IF JobPlanningLine."Planning Date" > gPerformanceDateTo THEN
            gPerformanceDateTo := JobPlanningLine."Planning Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnAfterCreateSalesInvoiceLines', '', false, false)]
    local procedure SubToOnAfterCreateSalesInvoiceLinesEvt(SalesHeader: Record "Sales Header"; NewInvoice: Boolean)
    var
        Factor: Integer;
        LineNo: Integer;
        SalesLine2: Record "Sales Line";
        SalesLine: Record "Sales Line";
        SourceSalesLine: Record "Sales Line";
        TempSalesLines: Record "Sales Line" temporary;
        JobPlanningLine: Record "Job Planning Line";
        JobPlanningLine1: Record "Job Planning Line";
        Consolidate: Boolean;
        JobPlanningLineInvoice: Record "Job Planning Line Invoice";
        JobPlanningLineInvoice2: Record "Job Planning Line Invoice";
        JPLQtyToTransferInv: Decimal;
        JPLLineNo: Integer;
        Job: record Job;
    begin

        Factor := 1;
        if SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then
            Factor := -1;
        SalesLine2.SetRange("Document No.", SalesHeader."No.");
        SalesLine2.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine2.setRange(Type, SalesLine2.Type::Resource);
        if SalesLine2.FindSet then
            repeat
                Consolidate := True;
                TempSalesLines := SalesLine2;
                TempSalesLines.Insert;
            //SalesLine2.Delete(true);
            until SalesLine2.Next = 0;

        if Consolidate then begin
            if TempSalesLines.Find('-') then
                repeat
                    GetJobPlanningLineInfo(TempSalesLines, JPLLineNo, JPLQtyToTransferInv);
                    JobPlanningLine1.get(TempSalesLines."Job No.", TempSalesLines."Job Task No.", JPLLineNo);
                    Job.get(JobPlanningLine1."Job No.");
                    Clear(SalesLine);
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SourceSalesLine.get(TempSalesLines."Document Type", TempSalesLines."Document No.", TempSalesLines."Line No.");
                    If (JobPlanningLine1.Type = JobPlanningLine1.Type::Resource) then begin
                        if not gTempoSetup."Consolidate Ressources on Inv." then
                            exit;
                    end;

                    If (JobPlanningLine1.Type = JobPlanningLine1.Type::"G/L Account") then begin
                        if not gTempoSetup."Consolidate Ressources on Inv." then
                            exit;
                    end;

                    SourceSalesLine.Delete(true);
                    JobPlanningLine.get(TempSalesLines."Job No.", TempSalesLines."Job Task No.", JPLLineNo);
                    CrtUpdConsolidatedLine(JobPlanningLine, SalesHeader."Bill-to Customer No.", Job, SalesLine, SalesHeader, Factor);

                    JobPlanningLineInvoice.Init();
                    JobPlanningLineInvoice."Job No." := JobPlanningLine."Job No.";
                    JobPlanningLineInvoice."Job Task No." := JobPlanningLine."Job Task No.";
                    JobPlanningLineInvoice."Job Planning Line No." := JobPlanningLine."Line No.";
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN
                        JobPlanningLineInvoice."Document Type" := JobPlanningLineInvoice."Document Type"::Invoice;
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN
                        JobPlanningLineInvoice."Document Type" := JobPlanningLineInvoice."Document Type"::"Credit Memo";
                    JobPlanningLineInvoice."Document No." := SalesHeader."No.";
                    JobPlanningLineInvoice."Line No." := SalesLine."Line No.";
                    JobPlanningLineInvoice."Quantity Transferred" := JobPlanningLine."Qty. to Transfer to Invoice";
                    JobPlanningLineInvoice."Transferred Date" := SalesHeader."Posting Date";
                    JobPlanningLineInvoice.INSERT;

                    JobPlanningLine.UpdateQtyToTransfer;
                    JobPlanningLine.MODIFY;
                until TempSalesLines.Next = 0;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnCreateSalesInvoiceJobTaskOnAfterLinesCreated', '', false, false)]
    local procedure SubToOnCreateSalesInvoiceJobTaskOnAfterLinesCreatedEvt(VAR SalesHeader: Record "Sales Header"; VAR Job: Record Job)
    var
        Factor: Integer;
        LineNo: Integer;
        SalesLine2: Record "Sales Line";
        SalesLine: Record "Sales Line";
        SourceSalesLine: Record "Sales Line";
        TempSalesLines: Record "Sales Line" temporary;
        JobPlanningLine: Record "Job Planning Line";
        JobPlanningLine1: Record "Job Planning Line";
        JobPlanningLine2: Record "Job Planning Line";
        Consolidate: Boolean;
        JobPlanningLineInvoice: Record "Job Planning Line Invoice";
        JobPlanningLineInvoice2: Record "Job Planning Line Invoice";
        JPLQtyToTransferInv: Decimal;
        JPLLineNo: Integer;
    begin

        Factor := 1;
        if SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then
            Factor := -1;
        SalesLine2.SetRange("Document No.", SalesHeader."No.");
        SalesLine2.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine2.setRange(Type, SalesLine2.Type::Resource);
        if SalesLine2.FindSet then
            repeat
                Consolidate := True;
                TempSalesLines := SalesLine2;
                TempSalesLines.Insert;
            //SalesLine2.Delete(true);
            until SalesLine2.Next = 0;

        if Consolidate then begin
            if TempSalesLines.Find('-') then
                repeat
                    GetJobPlanningLineInfo(TempSalesLines, JPLLineNo, JPLQtyToTransferInv);
                    JobPlanningLine1.get(TempSalesLines."Job No.", TempSalesLines."Job Task No.", JPLLineNo);
                    Clear(SalesLine);
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SourceSalesLine.get(TempSalesLines."Document Type", TempSalesLines."Document No.", TempSalesLines."Line No.");
                    GetTempoSetup(SalesHeader."Bill-to Customer No.");
                    If (JobPlanningLine1.Type = JobPlanningLine1.Type::Resource) then begin
                        if not gTempoSetup."Consolidate Ressources on Inv." then
                            exit;
                    end;

                    If (JobPlanningLine1.Type = JobPlanningLine1.Type::"G/L Account") then begin
                        if not gTempoSetup."Consolidate Ressources on Inv." then
                            exit;
                    end;

                    SourceSalesLine.Delete(true);
                    JobPlanningLine.get(TempSalesLines."Job No.", TempSalesLines."Job Task No.", JPLLineNo);
                    CrtUpdConsolidatedLine(JobPlanningLine, SalesHeader."Bill-to Customer No.", Job, SalesLine, SalesHeader, Factor);

                    JobPlanningLineInvoice.Init();
                    JobPlanningLineInvoice."Job No." := JobPlanningLine."Job No.";
                    JobPlanningLineInvoice."Job Task No." := JobPlanningLine."Job Task No.";
                    JobPlanningLineInvoice."Job Planning Line No." := JobPlanningLine."Line No.";
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN
                        JobPlanningLineInvoice."Document Type" := JobPlanningLineInvoice."Document Type"::Invoice;
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN
                        JobPlanningLineInvoice."Document Type" := JobPlanningLineInvoice."Document Type"::"Credit Memo";
                    JobPlanningLineInvoice."Document No." := SalesHeader."No.";
                    JobPlanningLineInvoice."Line No." := SalesLine."Line No.";
                    JobPlanningLineInvoice."Quantity Transferred" := JobPlanningLine."Qty. to Transfer to Invoice";
                    JobPlanningLineInvoice."Transferred Date" := SalesHeader."Posting Date";
                    JobPlanningLineInvoice.INSERT;

                    JobPlanningLine.UpdateQtyToTransfer;
                    JobPlanningLine.MODIFY;
                until TempSalesLines.Next = 0;
        end else begin
            JobPlanningLine2.RESET;
            JobPlanningLine2.SETCURRENTKEY("Job No.", "Job Task No.");
            JobPlanningLine2.SETRANGE("Job No.", gJobTask."Job No.");
            JobPlanningLine2.SETRANGE("Job Task No.", gJobTask."Job Task No.");
            JobPlanningLine2.SETFILTER("Planning Date", gJobTask.GETFILTER("Planning Date Filter"));
            IF JobPlanningLine2.FIND('-') THEN
                REPEAT
                    IF JobTransferLine(JobPlanningLine2) THEN BEGIN
                        gTempJobPlanningLine := JobPlanningLine2;
                        gTempJobPlanningLine.INSERT;
                    END;
                UNTIL JobPlanningLine2.NEXT = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeDeleteSalesLine', '', False, false)]
    local procedure SubToOnBeforeDeleteSalesLineEvt(VAR SalesLine: Record "Sales Line"; VAR IsHandled: Boolean)
    begin
        IF NOT SalesLine.BasedOnMultipleJobPlanningLns THEN
            // not consolidated, do standard check
            IF SalesLine."Job Contract Entry No." = 0 THEN
                IsHandled := true;
    end;

    procedure CrtUpdConsolidatedLine(var pJobPlanningLine: Record "Job Planning Line"; pBillToCustomer: Code[20]; Job: Record Job; VAR SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; pFactor: Decimal): Boolean
    var
        UnitPrice: Decimal;
        UnitCostLCY: Decimal;
        WorkType: Record "Work Type";
        GLAccountNo: Code[20];
        JobInvCurrency: Boolean;
        Currency: Record Currency;
    begin
        GetTempoSetup(pBillToCustomer);
        case pJobPlanningLine.Type of

            pJobPlanningLine.Type::Resource:
                begin
                    if not gTempoSetup."Consolidate Ressources on Inv." then
                        exit(false);

                    gTempoSetup.TestField("G/L Account No. for Cons.");
                    GLAccountNo := gTempoSetup."G/L Account No. for Cons.";
                end;

            pJobPlanningLine.Type::"G/L Account":
                begin
                    if not gCustomer."Consolidate G/L-Acc. Lines" then
                        exit(false); // to do uncomment

                    GLAccountNo := pJobPlanningLine."No.";
                end;
            else
                // consolidation not supported
                exit(false);

        end;


        // VAT in price handling is not supported
        SalesHeader.TestField("Prices Including VAT", false);

        // Line discounts are not supported
        pJobPlanningLine.TestField("Line Discount %", 0);

        if gCustomer."Prohibit Dummy Task lines inv."
            and (pJobPlanningLine."Job Task No." = gCustomer."ID for Dummy Job Task") then
            // this line is still being allocated to the "Auto-created task" and must not be invoiced
            Error(TxtLineStillAllocatedToAutoTask, pJobPlanningLine."Job No.", pJobPlanningLine."Job Task No.", pJobPlanningLine."Line No.", pJobPlanningLine."Planning Date");

        //++ysu        
        JobInvCurrency := (Job."Currency Code" = '') AND (Job."Invoice Currency Code" <> '');
        //---ysu
        with SalesLine do begin

            if JobInvCurrency then begin
                Currency.Get("Currency Code");
                UnitPrice := Round(pJobPlanningLine."Unit Price" * SalesHeader."Currency Factor",
                                                        Currency."Unit-Amount Rounding Precision")
            end else
                UnitPrice := pJobPlanningLine."Unit Price";

            SetRange("Document Type", SalesHeader."Document Type");
            SetRange("Document No.", SalesHeader."No.");

            SetRange("Job No.", pJobPlanningLine."Job No.");
            SetRange("Job Task No.", pJobPlanningLine."Job Task No.");

            SetRange(Type, Type::"G/L Account");
            SetRange("No.", GLAccountNo);
            SetRange("Work Type Code", pJobPlanningLine."Work Type Code");
            SetRange("Unit of Measure Code", pJobPlanningLine."Unit of Measure Code");

            SetRange("Unit Price", UnitPrice);

            if not FindFirst then begin
                // add a new invoice line
                Validate(Type, Type::"G/L Account");
                Validate("No.", GLAccountNo);

                "Line No." := GetNextLineNo(SalesLine);
                Insert(true);

                //VALIDATE("Location Code",JobPlanningLine."Location Code");

                Validate("Work Type Code", pJobPlanningLine."Work Type Code");
                //VALIDATE("Variant Code",JobPlanningLine."Variant Code");

                Validate("Unit of Measure Code", pJobPlanningLine."Unit of Measure Code");
                Validate(Quantity, pFactor * pJobPlanningLine."Qty. to Transfer to Invoice");

                Validate("Unit Price", UnitPrice);

                Validate("Unit Cost (LCY)", pJobPlanningLine."Unit Cost (LCY)");

                "Inv. Discount Amount" := 0;
                "Inv. Disc. Amount to Invoice" := 0;
                UpdateAmounts;

                //IF NOT SalesHeader."Prices Including VAT" THEN
                //  VALIDATE("Job Contract Entry No.", pJobPlanningLine."Job Contract Entry No.");

                "Job No." := pJobPlanningLine."Job No.";
                "Job Task No." := pJobPlanningLine."Job Task No.";

                BasedOnMultipleJobPlanningLns := true;

                pJobPlanningLine.CalcFields("Job Description", "Job Task Description");

                WorkType.Init;
                if pJobPlanningLine."Work Type Code" <> '' then
                    WorkType.Get(pJobPlanningLine."Work Type Code");
                ComputeDescriptions(gCustomer."Inv. Line Templ. Ressource"
                                                            , pJobPlanningLine."Job No."
                                                            , pJobPlanningLine."Job Description"
                                                            , pJobPlanningLine."Job Task No."
                                                            , pJobPlanningLine."Job Task Description"
                                                            , WorkType.Description
                                                            , ''
                                                            , SalesLine.Description
                                                            , SalesLine."Description 2"
                                                            , SalesLine."Long Description"
                                                            );
                PrintIndented := true; // to do uncomment
                Modify;

                // NoOfSalesLinesCreated += 1;

            end else begin
                // update existing line

                if pJobPlanningLine."Unit Cost (LCY)" <> "Unit Cost (LCY)" then
                    // compute new average unit cost
                    UnitCostLCY := ("Unit Cost (LCY)" * Quantity + pJobPlanningLine."Unit Cost (LCY)" * pJobPlanningLine."Qty. to Transfer to Invoice") / (Quantity + pJobPlanningLine."Qty. to Transfer to Invoice")
                else
                    UnitCostLCY := "Unit Cost (LCY)";

                Validate(Quantity, Quantity + pFactor * pJobPlanningLine."Qty. to Transfer to Invoice");
                Validate("Unit Cost (LCY)", UnitCostLCY);

                UpdateAmounts;
                Modify(true);
            end;

        end;

        exit(true);
    end;

    //to do move to SCSINV
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeInsertSalesLine', '', false, false)]
    local procedure SubToOnBeforeInsertSalesLineEvt(VAR SalesLine: Record "Sales Line"; VAR SalesHeader: Record "Sales Header"; Job: Record Job; JobPlanningLine: Record "Job Planning Line")
    begin
        JobPlanningLine.CALCFIELDS("Job Description");
        JobPlanningLine.CALCFIELDS("Job Task Description");
        ComputeDescriptions(gCustomer."Inv. Line Templ. G/L Account"
                            , JobPlanningLine."Job No."
                            , JobPlanningLine."Job Description"
                            , JobPlanningLine."Job Task No."
                            , JobPlanningLine."Job Task Description"
                            , JobPlanningLine.Description
                            , JobPlanningLine."Description 2"
                            , SalesLine.Description
                            , SalesLine."Description 2"
                            , SalesLine."Long Description"
                            );
        SalesLine.PrintIndented := TRUE;
    end;

    procedure ComputeDescriptions(Template: Text[100]; Var1: Text; Var2: Text[100]; Var3: Text[100]; Var4: Text[100]; Var5: Text[100]; Var6: Text[100]; var Desc1: Text[50]; var Desc2: Text[50]; var LongDesc: Text[100])
    var
        CompleteDescription: Text;
    begin
        CompleteDescription := StrSubstNo(Template, Var1, Var2, Var3, Var4, Var5, Var6);
        if StrLen(CompleteDescription) > MaxStrLen(CompleteDescription) then
            CompleteDescription := CopyStr(CompleteDescription, 1, MaxStrLen(CompleteDescription) - -3) + '...';

        Desc1 := CopyStr(CompleteDescription, 1, 50);
        Desc2 := CopyStr(CompleteDescription, 51, 50);
        LongDesc := CopyStr(CompleteDescription, 1, 100);
    end;

    procedure GetTempoSetup(pBillToCustomer: Code[20])
    begin
        gTempoSetup.Init;
        //gTempoSetup.Get; //++YSU
        gTempoSetup.Get('TEST'); //remove this code +++YSU
        gCustomer.Get(pBillToCustomer);
    end;

    procedure UpdateCreateSalesInvoiceJTPara(SourceOldBTCustNo: Code[20]; SourceBreakLevel: Option)
    begin
        gOldBTCustNo := SourceOldBTCustNo;
        gBreakLevel := SourceBreakLevel;
    end;

    local procedure GetNextLineNo(SalesLine: Record "Sales Line"): Integer
    var
        NextLineNo: Integer;
    begin
        SalesLine.SetRange("Document Type", SalesLine."Document Type");
        SalesLine.SetRange("Document No.", SalesLine."Document No.");
        NextLineNo := 10000;
        if SalesLine.FindLast then
            NextLineNo := SalesLine."Line No." + 10000;
        exit(NextLineNo);
    end;

    procedure GetJobPlanningLineInfo(var SalesLine2: Record "Sales Line"; var JPLLineNo: Integer; var JPLQtyToTransferInv: Decimal)
    var
        JobPlanningLineInvoice: Record "Job Planning Line Invoice";
    begin
        JobPlanningLineInvoice.SetRange("Job No.", SalesLine2."Job No.");
        JobPlanningLineInvoice.SetRange("Job Task No.", SalesLine2."Job Task No.");

        JobPlanningLineInvoice.SetRange("Document No.", SalesLine2."Document No.");
        JobPlanningLineInvoice.SetRange("Line No.", SalesLine2."Line No.");

        if SalesLine2."Document Type" = SalesLine2."Document Type"::Invoice then
            JobPlanningLineInvoice.SetRange("Document Type", JobPlanningLineInvoice."Document Type"::Invoice);
        if SalesLine2."Document Type" = SalesLine2."Document Type"::"Credit Memo" then
            JobPlanningLineInvoice.SetRange("Document Type", JobPlanningLineInvoice."Document Type"::"Credit Memo");


        if JobPlanningLineInvoice.findfirst then begin
            JPLLineNo := JobPlanningLineInvoice."Job Planning Line No.";
            JPLQtyToTransferInv := JobPlanningLineInvoice."Quantity Transferred";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeCreateSalesInvoiceJobTask', '', false, false)]
    local procedure SubToOnBeforeCreateSalesInvoiceJobTaskEvt(VAR JobTask2: Record "Job Task"; PostingDate: Date; InvoicePerTask: Boolean; VAR NoOfInvoices: Integer; VAR OldJobNo: Code[20]; VAR OldJobTaskNo: Code[20]; LastJobTask: Boolean; VAR IsHandled: Boolean)
    begin
        gJobTask := JobTask2;
    end;

    procedure SetOldBTCustNo(): Code[20]
    begin
        Exit(gOldBTCustNo);

    end;

    procedure JobTransferLine(VAR JobPlanningLine: Record "Job Planning Line"): Boolean
    begin

        WITH JobPlanningLine DO BEGIN
            IF NOT "Contract Line" THEN
                EXIT(FALSE);
            IF Type = Type::Text THEN
                EXIT(TRUE);
            EXIT("Qty. to Transfer to Invoice" <> 0);
        END;

    End;

}