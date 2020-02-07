pageextension 50129 "SCSINVSales Quote Subform" extends "Sales Quote Subform"
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
        addafter("VAT Prod. Posting Group")
        {
            // to do how to add sytle to description field
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
        addafter("Allow Invoice Disc.")
        {
            field(EstimationPrecisionClass; "Estimation (Precision) Class")
            {
                ApplicationArea = All;                //3rd upgrade
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
        ShowShortcutDimCode(ShortcutDimCode);

        LineStyle := ComputeLineStyle;
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        LineStyle: Text;
}