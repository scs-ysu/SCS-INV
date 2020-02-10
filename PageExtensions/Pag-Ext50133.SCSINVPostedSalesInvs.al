pageextension 50133 "SCSINV Posted Sales Invs" extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Location Code")
        {
            field(ExternalDocumentNo; "External Document No.")
            {
                ApplicationArea = All;
                Description = 'SCS1.00';
            }
        }
        addlast(FactBoxes)
        {
            part(AttachmentsFB; Attachments)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(ActivityLog)
        {
            action("Inv&Attachments2PDF")
            {
                ApplicationArea = All;
                Caption = 'Join Invoice and PDF attachments';
                //Image = pdf; +++ YSU
                Image = SendAsPDF; //+++ysu
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.AttachmentsFB.Page.PrintInvoiceAndAttachPDFs(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Rec);
        CurrPage.AttachmentsFB.Page.SetParentRecRef(RecRef);

    end;

    var
        myInt: Integer;
}