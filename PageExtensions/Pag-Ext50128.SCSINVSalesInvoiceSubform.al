pageextension 50128 "SCSINVSales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Type)
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

        addafter("VAT Prod. Posting Group")
        {
            field(Description2; "Description 2")
            {
                ApplicationArea = All;
                StyleExpr = LineStyle;
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

    trigger OnAfterGetRecord()
    begin

        LineStyle := ComputeLineStyle;
    end;
}