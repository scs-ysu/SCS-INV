tableextension 50123 "SCSINVCompany Information" extends "Company Information"
{

    fields
    {
        field(50000; "One-Line Company Address"; Text[100])
        {
            Caption = 'One-Line Company Address';
            DataClassification = CustomerContent;

        }
        field(50001; "Document Footer Line 1"; Text[100])
        {
            Caption = 'Document Footer Line 1';
            DataClassification = CustomerContent;

        }
        field(50002; "Document Footer Line 2"; Text[100])
        {
            Caption = 'Document Footer Line 2';
            DataClassification = CustomerContent;

        }
        field(50100; "Quote Expiry Date Formula"; DateFormula)
        {
            Caption = 'Quote Expiry Date Formula';
            DataClassification = CustomerContent;

        }
    }

    procedure GetOneLineCompanyAddress(): Text[132]
    begin
        exit(CopyStr(StrSubstNo("One-Line Company Address", Name, Address, "Address 2", "Post Code", City), 1, 132));
    end;

    procedure GetFooterLine1(): Text[132]
    begin
        exit(CopyStr(StrSubstNo("Document Footer Line 1", "VAT Registration No.", IBAN, "SWIFT Code"), 1, 132));
    end;

    procedure GetFooterLine2(): Text[132]
    begin
        exit(CopyStr(StrSubstNo("Document Footer Line 2", "VAT Registration No.", IBAN, "SWIFT Code"), 1, 132));
    end;
}

