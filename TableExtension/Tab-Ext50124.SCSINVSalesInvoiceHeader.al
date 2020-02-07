tableextension 50124 "SCSINVSales Invoice Header" extends "Sales Invoice Header"
{

    fields
    {
        field(50000; "Performance Date From"; Date)
        {
            Caption = 'Performance Date From';
            DataClassification = CustomerContent;

        }
        field(50010; "Performance Date To"; Date)
        {
            Caption = 'Performance Date To';
            DataClassification = CustomerContent;

        }
        field(50020; "Invoice Header Text"; Text[250])
        {
            Caption = 'Invoice Header Text';
            DataClassification = CustomerContent;

        }
    }

    keys
    {
    }

    fieldgroups
    {
    }
}

