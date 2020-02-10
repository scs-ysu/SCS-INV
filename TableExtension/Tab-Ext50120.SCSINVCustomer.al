tableextension 50120 "SCSINVCustomer" extends Customer
{

    fields
    {
        field(50120; "Group by Job"; Boolean)
        {
            Caption = 'Group by Job Task';
            DataClassification = CustomerContent;

        }
        field(50130; "Inv. Header Templ."; Text[250])
        {
            Caption = 'Template for invoice header text';
            DataClassification = CustomerContent;

        }
        field(50140; "Inv. Line Templ. Job"; Text[50])
        {
            Caption = 'Inv Line Description Template - Job Header';
            DataClassification = CustomerContent;

        }
        field(50150; "Inv. Line Templ. Ressource"; Text[50])
        {
            Caption = 'Invoice Template - Planning Line';
            DataClassification = CustomerContent;

        }
        field(50160; "Inv. Line Templ. G/L Account"; Text[50])
        {
            Caption = 'Inv. Line Templ. G/L Account';
            DataClassification = CustomerContent;

        }
        field(50190; "Use Default Work Type"; Boolean)
        {
            Caption = 'Use Default Work Type';
            DataClassification = CustomerContent;

        }
        field(50200; "Default Work Type"; Code[10])
        {
            Caption = 'Default Work Type';
            DataClassification = CustomerContent;

            TableRelation = "Work Type";
        }
        field(50210; "Consolidate G/L-Acc. Lines"; Boolean)
        {
            Caption = 'Consolidate G/L-Acc. Lines in Invoice';
            DataClassification = CustomerContent;

        }

        field(50220; "Template Workbook"; Text[250])
        {
            DataClassification = CustomerContent;

        }
        field(50230; "Target Folder"; Text[250])
        {
            DataClassification = CustomerContent;

        }
        field(50240; "Filename Template"; Text[250])
        {
            DataClassification = CustomerContent;

        }
        field(50250; "E-Mail for PDF Invoice"; Text[80])
        {
            Caption = 'E-Mail for PDF Invoice';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
    }

    keys
    {
    }

    fieldgroups
    {
    }
}

