pageextension 50134 "SCSINVPosted Sales Inv Subform" extends "Posted Sales Invoice Subform"
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
        addafter("Variant Code")
        {
            field(Description2; "Description 2")
            {
                ApplicationArea = All;
                StyleExpr = LineStyle;
            }
            field(LongDescription; "Long Description")
            {
                ApplicationArea = All;
                StyleExpr = LineStyle;
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

    trigger OnAfterGetRecord()
    begin

        LineStyle := ComputeLineStyle;
    end;

    var
        LineStyle: Text;
}