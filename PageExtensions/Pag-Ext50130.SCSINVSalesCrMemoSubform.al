pageextension 50130 "SCSINVSales Cr Memo Subform" extends "Sales Cr. Memo Subform"
{
    layout
    {
        // Add changes to page layout here
        addfirst(Control1)
        {
            field(PrintBold; PrintBold)
            {
                ApplicationArea = All;

            }
            field(PrintItalics; PrintItalics)
            {
                ApplicationArea = All;

            }
            field(PrintIndented; PrintIndented)
            {
                ApplicationArea = All;

            }
        }
        addbefore("Return Reason Code")
        {
            // description sytle 
            field(Description2; "Description 2")
            {
                ApplicationArea = All;
                StyleExpr = LineStyle;
            }
            field(LongDescription; "Long Description")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }

        modify(Description)
        {
            StyleExpr = LineStyle;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        LineStyle: Text;
}