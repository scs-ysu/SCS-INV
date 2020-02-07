pageextension 50125 "SCSINVGeneral Journal" extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Posting Date")
        {
            field(LineNo; "Line No.")
            {
                ApplicationArea = All;
                Description = 'SCSINV1.00';
                Editable = false;
                Visible = false;
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