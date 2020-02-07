pageextension 50120 "SCSINVTEMPO - Customer Setup" extends "SCSJIFTEMPO - Customer Setup"
{
    layout
    {
        addlast(content)
        {

            field(QtyBaseFractionMin; "Qty. (Base) Fraction (min)")
            {
                ApplicationArea = All;
            }
            field(GroupByJob; "Group by Job")
            {
                ApplicationArea = All;
            }
            field(UseDefaultWorkType; "Use Default Work Type")
            {
                ApplicationArea = All;
            }
            field(DefaultWorkType; "Default Work Type")
            {
                ApplicationArea = All;
            }
            field(InvHeaderTempl; "Inv. Header Templ.")
            {
                ApplicationArea = All;
            }
            field(InvLineTemplJob; "Inv. Line Templ. Job")
            {
                ApplicationArea = All;
            }
            field(InvLineTemplRessource; "Inv. Line Templ. Ressource")
            {
                ApplicationArea = All;
            }
            field(InvLineTemplGLAccount; "Inv. Line Templ. G/L Account")
            {
                ApplicationArea = All;
            }
            field(GLAccountForExpenses; "G/L Account for Expenses")
            {
                ApplicationArea = All;
            }
            field(UnitForExpenses; "Unit for Expenses")
            {
                ApplicationArea = All;
            }
            field(ConsolidateGLAccLines; "Consolidate G/L-Acc. Lines")
            {
                ApplicationArea = All;
            }

        }


    }

}

