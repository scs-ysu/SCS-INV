pageextension 50123 "SCSINV posted Sales Cr. Memo" extends "Posted Sales Credit Memos"
{
    layout
    {
        // Add changes to page layout here
        addlast(FactBoxes)
        {
            part(AttachmentsFB; "Attachments")
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
            action("CM&Attachments2PDF")
            {
                Caption = 'Join Credit Memo and PDF attachments';
                //Image = pdf; +++YSU
                ApplicationArea = All;
                Image = SendAsPDF; //+++ysu
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.AttachmentsFB.Page.PrintCreditMemoAndAttachPDFs(Rec);
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