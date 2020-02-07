pageextension 50136 "SCSINVSales Statistics" extends "Sales Statistics"
{


    layout
    {
        // Add changes to page layout here
        addbefore(Customer)
        {
            part(Control1000000000; "SCSJIFSales Doc. Statistics")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"),
                              "Document No." = field("No.");
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