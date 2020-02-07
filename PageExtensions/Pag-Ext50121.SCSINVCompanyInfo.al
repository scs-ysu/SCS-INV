pageextension 50121 "SCSINVCompany Info" extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field(OneLineCompanyAddress; "One-Line Company Address")
            {
                ToolTipML = DEU = 'Z.B. als Absenderadresse in Dokumenten. Unterstützt Plathalter: %1=NAME, %2=ADRESSE 1, %3=ADRESSE 2, %4=PLZ, %5=ORT',
                                ENU = 'Used e.g. as sender''s address in documents. Supports Placeholders: %1=NAME, %2=ADDRESS 1, %3=ADDRESS 2, %4=POST CODE, %5=CITY';
                ApplicationArea = All;
            }
            field("Resulting One-Line Company Address"; GetOneLineCompanyAddress)
            {
                CaptionML = DEU = 'Resultierende einzeilige Firmenadresse',
                                ENU = 'Resulting One-Line Company Address';
                Editable = false;
                ApplicationArea = All;
            }
            field(DocumentFooterLine1; "Document Footer Line 1")
            {
                ToolTipML = DEU = 'Z.B. als Fußzeile in Dokumenten. Unterstützt Platzhalter:  %1=UST ID, %2=IBAN, %3=BIC',
                                ENU = 'Used e.g. as footer line  in documents. Supports placeholders: %1=VAT ID, %2=IBAN, %3=SWIFT';
                ApplicationArea = All;
            }
            field("Resulting Footer Line 1"; GetFooterLine1)
            {
                CaptionML = DEU = 'Resultierende Fußzeile 1',
                                ENU = 'Resulting Footer Line 1';
                Editable = false;
                ApplicationArea = All;
            }
            field(DocumentFooterLine2; "Document Footer Line 2")
            {
                ToolTipML = DEU = 'Z.B. als Fußzeile in Dokumenten. Unterstützt Platzhalter:  %1=UST ID, %2=IBAN, %3=BIC',
                                ENU = 'Used e.g. as footer line  in documents. Supports placeholders: %1=VAT ID, %2=IBAN, %3=SWIFT';
                ApplicationArea = All;
            }
            field("Resulting Footer Line 2"; GetFooterLine2)
            {
                CaptionML = DEU = 'Resultierende Fußzeile 2',
                                ENU = 'Resulting Footer Line 2';
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter(General)
        {
            group(SCSSpecificSettings)
            {
                CaptionML = DEU = 'SCS-spezifische Einstellungen',
                            ENU = 'SCS specific settings';
                Description = 'Added SCSINV1.00';
                field(QuoteExpiryDateFormula; "Quote Expiry Date Formula")
                {
                    ApplicationArea = All;
                }
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