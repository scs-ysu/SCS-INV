tableextension 50128 "SCSINVSales Line Archive" extends "Sales Line Archive"
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

        field(50014; "Estimation (Precision) Class"; Option)
        {
            Caption = 'Estimation (Precision) Class';
            DataClassification = CustomerContent;
            Description = 'SCS1.00'; // 3rd update
            OptionCaption = ' ,Class 1,Class 2,Class 3,Class 4,Class 5,,,,,,XS,S,M,L,XL,XXL';
            OptionMembers = " ","Class 1","Class 2","Class 3","Class 4","Class 5",,,,,,XS,S,M,L,XL,XXL;
        }
    }

    keys
    {
    }

    fieldgroups
    {
    }
}

