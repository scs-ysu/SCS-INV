pageextension 50126 "SCSINVSales Quote" extends "Sales Quote"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Document Date")
        {
            field(QuoteExpiryDate; "Quote Expiry Date")
            {
                ApplicationArea = All;

                trigger OnAssistEdit()
                var
                    DefaultDate: Date;
                    CompanyInfo: Record "Company Information";
                begin
                    CompanyInfo.Get;
                    CompanyInfo.TestField("Quote Expiry Date Formula");
                    DefaultDate := CalcDate(CompanyInfo."Quote Expiry Date Formula", WorkDate);
                    if Confirm(Text_SetQuoteExpiryDateToDft, true, FieldCaption("Quote Expiry Date"), "Quote Expiry Date", DefaultDate, CompanyInfo."Quote Expiry Date Formula") then
                        "Quote Expiry Date" := DefaultDate;
                end;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        Text_SetQuoteExpiryDateToDft: TextConst DEU = '%1 mittels Formel %4 von %2 auf %3 setzen?', ENU = 'Set %1 from %2 to %3 using formula %4?';
}