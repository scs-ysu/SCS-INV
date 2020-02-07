report 50120 "SCSINVJob Create Sales Invoice"
{
    CaptionML = DEU = 'SCS Verkaufsrechnung erstellen Projekt',
                ENU = 'SCS Job Create Sales Invoice';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Job Task"; "Job Task")
        {
            CalcFields = "Bill-to Customer No.";
            DataItemTableView = sorting("Job No.", "Job Task No.");
            RequestFilterFields = "Job No.", "Job Task No.", "Planning Date Filter";

            trigger OnAfterGetRecord()
            begin
                //SCSMIGNAV20162BC 14.08.19 YSU +++
                /*
                JobCreateInvoice.CreateSalesInvoiceJT(
                    //"Job Task",PostingDate,InvoicePerTask,NoOfInvoices,OldJobNo,OldJTNo,FALSE); // SCS1.00 10.05.14 CBO *deleted*
                    "Job Task", PostingDate, InvoicePerTask, NoOfInvoices, OldJobNo, OldJTNo, false, OldBTCustNo, BreakLevel); // SCS1.00 10.05.14 CBO +++
                */
                SCSJobCreateInv.UpdateCreateSalesInvoiceJTPara(OldBTCustNo, BreakLevel);
                JobCreateInvoice.CreateSalesInvoiceJobTask("Job Task", PostingDate, InvoicePerTask, NoOfInvoices, OldJobNo, OldJTNo, false); //to do
                OldBTCustNo := SCSJobCreateInv.SetOldBTCustNo();
                //SCSMIGNAV20162BC 14.08.19 YSU ---
            end;

            trigger OnPostDataItem()
            begin
                //SCSMIGNAV20162BC 14.08.19 YSU +++
                /*
                JobCreateInvoice.CreateSalesInvoiceJT(
                    //"Job Task",PostingDate,InvoicePerTask,NoOfInvoices,OldJobNo,OldJTNo,TRUE); // SCS1.00 10.05.14 CBO *deleted*
                    "Job Task", PostingDate, InvoicePerTask, NoOfInvoices, OldJobNo, OldJTNo, TRUE, OldBTCustNo, BreakLevel); // SCS1.00 10.05.14 CBO +++
                */
                SCSJobCreateInv.UpdateCreateSalesInvoiceJTPara(OldBTCustNo, BreakLevel);
                JobCreateInvoice.CreateSalesInvoiceJobTask("Job Task", PostingDate, InvoicePerTask, NoOfInvoices, OldJobNo, OldJTNo, true); //to do
                OldBTCustNo := SCSJobCreateInv.SetOldBTCustNo();
                //SCSMIGNAV20162BC 14.08.19 YSU ---
            end;

            trigger OnPreDataItem()
            begin
                NoOfInvoices := 0;
                OldJobNo := '';
                OldJTNo := '';

                OldBTCustNo := '';  // SCS1.00 10.05.14 CBO +++
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = DEU = 'Optionen',
                                ENU = 'Options';
                    field(PostingDate; PostingDate)
                    {
                        CaptionML = DEU = 'Buchungsdatum',
                                    ENU = 'Posting Date';
                    }
                    field(JobChoice; JobChoice)
                    {
                        CaptionML = DEU = 'Rechnung erstellen für Datum',
                                    ENU = 'Create Invoice per';
                        Description = 'SCSINV1.00: Made invisible';
                        OptionCaptionML = DEU = 'Projekt,Projektaufgabe',
                                          ENU = 'Job,Job Task';
                        Visible = false;
                    }
                    field(BreakLevel; BreakLevel)
                    {
                        Caption = 'Create Invoice per';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PostingDate := WorkDate;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        JobCalcBatches.EndCreateInvoice(NoOfInvoices);
    end;

    trigger OnPreReport()
    begin
        JobCalcBatches.BatchError(PostingDate, Text000);
        // InvoicePerTask := JobChoice = JobChoice::"Job Task"; // SCS1.00 10.05.14 CBO *deleted*
        JobCreateInvoice.DeleteSalesInvoiceBuffer;
    end;

    var
        JobCreateInvoice: Codeunit "Job Create-Invoice";
        JobCalcBatches: Codeunit "Job Calculate Batches";
        PostingDate: Date;
        NoOfInvoices: Integer;
        InvoicePerTask: Boolean;
        JobChoice: Option Job,"Job Task";
        OldJobNo: Code[20];
        OldJTNo: Code[20];
        Text000: TextConst DEU = 'A', ENU = 'A', Comment = 'A';
        "*** SCS1.00": Integer;
        OldBTCustNo: Code[20];
        BreakLevel: Option Customer,Job,"Job Task";
        SCSJobCreateInv: Codeunit "SCSINVJob Create Invoice";

    procedure SetOldBTCustNo(): Code[20]
    begin

        EXIT(OldBTCustNo);
    end;

    procedure SetBreakLevel(): Option

    begin
        EXIT(BreakLevel);
    end;
}

