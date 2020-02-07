pageextension 50131 "SCSINVGeneral Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("LCY Code")
        {
            field(LCYSymbol; "Local Currency Symbol")
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