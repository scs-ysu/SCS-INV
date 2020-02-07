pageextension 50127 "SCSINVSales Invoice" extends "Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Document Date")
        {
            field(PerformanceDateFrom; "Performance Date From")
            {
                ApplicationArea = All;
            }
            field(PerformanceDateTo; "Performance Date To")
            {
                ApplicationArea = All;
            }

        }
        addbefore("External Document No.")
        {
            field(Control1000000004; Comment)
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