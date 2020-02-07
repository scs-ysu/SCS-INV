codeunit 50120 "SCSINV Event Subcriber"
{
    SingleInstance = true;
    trigger OnRun()
    begin

    end;

    var
        Txt_SalesDocIsNotReleased: TextConst DEU = '%1 %2 ist nicht freigegeben. Sind Sie sicher, dass Sie fortsetzen wollen?', ENU = '%1 %2 has not been released. Are you sure that you want to continue?';
        Txt_Error_SalesDocIsNotReleased: TextConst DEU = '%1 %2 ist nicht freigegeben. Druck abgebrochen.', ENU = '%1 %2 has not been released. Printing aborted.';

        myInt: Integer;
        CompanyInfo: Record "Company Information";
        gRepricingMode: Boolean;

        gPerformanceDateFrom: Date;
        gPerformanceDateTo: Date;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitRecord', '', false, false)]
    local procedure OnAfterInitRecordSalesHeader(var SalesHeader: Record "Sales Header")
    begin
        // +++ SCSINV1.00 CBO 02.02.17
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Quote THEN BEGIN
            CompanyInfo.GET;
            CompanyInfo.TESTFIELD("Quote Expiry Date Formula");
            SalesHeader."Quote Expiry Date" := CALCDATE(CompanyInfo."Quote Expiry Date Formula", WORKDATE);
        END;
        // --- SCSINV1.00 CBO 02.02.17
    end;

    //CU 229
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforeCalcSalesDisc', '', false, false)]
    local procedure SubToOnBeforeCalcSalesDiscEvt(VAR SalesHeader: Record "Sales Header"; VAR IsHandled: Boolean)
    begin
        IsHandled := false; //14.08.19 YSU
        if SalesHeader.Status <> SalesHeader.Status::Released then
            if not Confirm(Txt_SalesDocIsNotReleased, true, Format(SalesHeader."Document Type"), SalesHeader."No.") then
                Error(Txt_Error_SalesDocIsNotReleased, Format(SalesHeader."Document Type"), SalesHeader."No.");
    end;



    // table "Job Planning Line" 
    // To do check with Carsten if it is available in SCSINV or SCSJIF
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure OnAfterValidateJPLNo(var Rec: Record "Job Planning Line"; var xRec: Record "Job Planning Line"; CurrFieldNo: Integer)
    var
        Customer: Record "Customer";
        Job: Record Job;
        Res: Record Resource;
    begin

        case Rec.Type of
            Rec.Type::Resource:
                begin
                    // SCS1.00 +++
                    Rec.GetCustomer(Job."Bill-to Customer No.");
                    if Customer."Use Default Work Type" then
                        Rec.Validate("Work Type Code", Customer."Default Work Type")
                    else
                        if Job."Internal Job" then begin
                            Res.TestField("Default Work Type Code Int.");
                            Rec.Validate("Work Type Code", Res."Default Work Type Code Int.")
                        end else begin
                            Res.TestField("Default Work Type Code");
                            Rec.Validate("Work Type Code", Res."Default Work Type Code");
                        end;
                    // SCS1.00 ---
                    Rec.Validate("Unit of Measure Code", Res."Base Unit of Measure");
                end;
        end;
        // SCSMIGNAV20162BC 12.08.19 YSU  ---
    end;




}