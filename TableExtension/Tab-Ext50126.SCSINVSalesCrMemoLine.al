tableextension 50126 "SCSINVSales Cr.Memo Line" extends "Sales Cr.Memo Line"
{

    fields
    {
        field(50010; PrintBold; Boolean)
        {
            Caption = 'Bold';
            DataClassification = CustomerContent;

        }
        field(50011; PrintItalics; Boolean)
        {
            Caption = 'Italics';
            DataClassification = CustomerContent;

        }
        field(50012; PrintIndented; Boolean)
        {
            Caption = 'Indt';
            DataClassification = CustomerContent;

        }
        field(50013; "Long Description"; Text[100])
        {
            Caption = 'Long Description';
            DataClassification = CustomerContent;

        }
    }


}

