pageextension 50132 "SCSINVPosted Sales Invoice" extends "Posted Sales Invoice"
{

    layout
    {
        // Add changes to page layout here
        addafter("External Document No.")
        {
            field(PerformanceDateFrom; "Performance Date From")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(PerformanceDateTo; "Performance Date To")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(YourReference; "Your Reference")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Comment; Comment)
            {
                ApplicationArea = All;
            }
        }
        addafter("No. Printed")
        {
            field(InvoiceHeaderText; "Invoice Header Text")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}