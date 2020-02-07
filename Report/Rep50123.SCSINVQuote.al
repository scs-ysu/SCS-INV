report 50123 "SCSINV Quote"
{

    // Created as copy of 1304, merged with 51000

    CaptionML = DEU = 'Verkauf - Angebot',
                ENU = 'SCS Sales - Quote';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './SCS Quote.rdl';
    WordMergeDataItem = Header;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeadingML = DEU = 'Verkaufsangebot',
                                     ENU = 'Sales Quote';
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl)
            {
            }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoLbl)
            {
            }
            column(CompanyBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameLbl)
            {
            }
            column(CompanyBankBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyBankBranchNo_Lbl; CompanyInfo.FieldCaption("Bank Branch No."))
            {
            }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoLbl)
            {
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyIBAN_Lbl; CompanyInfo.FieldCaption(IBAN))
            {
            }
            column(CompanySWIFT; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanySWIFT_Lbl; CompanyInfo.FieldCaption("SWIFT Code"))
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber)
            {
            }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyLegalOffice; CompanyInfo.GetLegalOffice)
            {
            }
            column(CompanyLegalOffice_Lbl; CompanyInfo.GetLegalOfficeLbl)
            {
            }
            column(CompanyCustomGiro; CompanyInfo.GetCustomGiro)
            {
            }
            column(CompanyCustomGiro_Lbl; CompanyInfo.GetCustomGiroLbl)
            {
            }
            column(CompanyLegalStatement; GetLegalStatement)
            {
            }
            column(CustomerAddress1; CustAddr[1])
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(CustomerAddress7; CustAddr[7])
            {
            }
            column(CustomerAddress8; CustAddr[8])
            {
            }
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(YourReference__Lbl; FieldCaption("Your Reference"))
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
            {
            }
            column(Shipment_Lbl; ShipmentLbl)
            {
            }
            column(ShowShippingAddress; ShowShippingAddr)
            {
            }
            column(ShipToAddress_Lbl; ShiptoAddrLbl)
            {
            }
            column(ShipToAddress1; ShipToAddr[1])
            {
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(PaymentMethodDescription_Lbl; PaymentMethodDescLbl)
            {
            }
            column(DocumentCopyText; StrSubstNo(DocumentCaption, CopyText))
            {
            }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustomerNo_Lbl; FieldCaption("Bill-to Customer No."))
            {
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(DocumentDate_Lbl; FieldCaption("Document Date"))
            {
            }
            column(DueDate; Format("Due Date", 0, 4))
            {
            }
            column(DueDate_Lbl; FieldCaption("Due Date"))
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(DocumentNo_Lbl; InvNoLbl)
            {
            }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PricesIncludingVAT_Lbl; FieldCaption("Prices Including VAT"))
            {
            }
            column(PricesIncludingVATYesNo; Format("Prices Including VAT"))
            {
            }
            column(SalesPerson_Lbl; SalespersonLbl)
            {
            }
            column(SalesPersonBlank_Lbl; SalesPersonText)
            {
            }
            column(SalesPersonName; SalespersonPurchaser.Name)
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerNo_Lbl; FieldCaption("Sell-to Customer No."))
            {
            }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber)
            {
            }
            column(VATRegistrationNo_Lbl; GetCustomerVATRegistrationNumberLbl)
            {
            }
            column(GlobalLocationNumber; GetCustomerGlobalLocationNumber)
            {
            }
            column(GlobalLocationNumber_Lbl; GetCustomerGlobalLocationNumberLbl)
            {
            }
            column(LegalEntityType; Cust.GetLegalEntityType)
            {
            }
            column(LegalEntityType_Lbl; Cust.GetLegalEntityTypeLbl)
            {
            }
            column(Copy_Lbl; CopyLbl)
            {
            }
            column(EMail_Lbl; EMailLbl)
            {
            }
            column(HomePage_Lbl; HomePageLbl)
            {
            }
            column(InvoiceDiscountBaseAmount_Lbl; InvDiscBaseAmtLbl)
            {
            }
            column(InvoiceDiscountAmount_Lbl; InvDiscountAmtLbl)
            {
            }
            column(LineAmountAfterInvoiceDiscount_Lbl; LineAmtAfterInvDiscLbl)
            {
            }
            column(LocalCurrency_Lbl; LocalCurrencyLbl)
            {
            }
            column(ExchangeRateAsText; ExchangeRateText)
            {
            }
            column(Page_Lbl; PageLbl)
            {
            }
            column(SalesInvoiceLineDiscount_Lbl; SalesInvLineDiscLbl)
            {
            }
            column(DocumentTitle_Lbl; SalesConfirmationLbl)
            {
            }
            column(Subtotal_Lbl; SubtotalLbl)
            {
            }
            column(Total_Lbl; TotalLbl)
            {
            }
            column(VATAmount_Lbl; VATAmtLbl)
            {
            }
            column(VATBase_Lbl; VATBaseLbl)
            {
            }
            column(VATAmountSpecification_Lbl; VATAmtSpecificationLbl)
            {
            }
            column(VATClauses_Lbl; VATClausesLbl)
            {
            }
            column(VATIdentifier_Lbl; VATIdentifierLbl)
            {
            }
            column(VATPercentage_Lbl; VATPercentageLbl)
            {
            }
            column(VATClause_Lbl; VATClause.TableCaption)
            {
            }
            column(SCSINV100_NewFields_SalesInvoiceHeader; '***SCSINV1.00***')
            {
            }
            column(SalesPersonEMail; SalespersonPurchaser."E-Mail")
            {
            }
            column(SalesPersonPhoneNo; SalespersonPurchaser."Phone No.")
            {
            }
            column(OneLineCompanyAddress; CompanyInfo.GetOneLineCompanyAddress)
            {
            }
            column(FooterLine1; CompanyInfo.GetFooterLine1)
            {
            }
            column(FooterLine2; CompanyInfo.GetFooterLine2)
            {
            }
            column(InvoiceHeaderText; "Invoice Header Text")
            {
            }
            column(CurrencyFormat; gCurrencyFormat)
            {
            }
            column(SCS_SalesPerson_Lbl; Text_SCS_SalesPerson_Lbl)
            {
            }
            column(SCS_QuoteExpirationTerms; gSCS_QuoteExpirationTerms)
            {
            }
            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
                UseTemporary = true;
                column(LineNo_Line; "Line No.")
                {
                }
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount))
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(Description_Line; Description)
                {
                }
                column(Description_Line_Lbl; FieldCaption(Description))
                {
                }
                column(LineDiscountPercent_Line; "Line Discount %")
                {
                }
                column(LineDiscountPercentText_Line; LineDiscountPctText)
                {
                }
                column(LineAmount_Line; "Line Amount")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_Line_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(ItemNo_Line_Lbl; FieldCaption("No."))
                {
                }
                column(ShipmentDate_Line; Format(PostedShipmentDate))
                {
                }
                column(ShipmentDate_Lbl; PostedShipmentDateLbl)
                {
                }
                column(Quantity_Line; Quantity)
                {
                }
                column(Quantity_Line_Lbl; FieldCaption(Quantity))
                {
                }
                column(Type_Line; Format(Type))
                {
                }
                column(UnitPrice; "Unit Price")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                column(UnitPrice_Lbl; FieldCaption("Unit Price"))
                {
                }
                column(UnitOfMeasure; "Unit of Measure")
                {
                }
                column(UnitOfMeasure_Lbl; FieldCaption("Unit of Measure"))
                {
                }
                column(VATIdentifier_Line; "VAT Identifier")
                {
                }
                column(VATIdentifier_Line_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_Line; "VAT %")
                {
                }
                column(VATPct_Line_Lbl; FieldCaption("VAT %"))
                {
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(SCSINV100_NewFields_SalesInvoiceLine; '***SCSINV1.00***')
                {
                }
                column(Description2_Line; "Description 2")
                {
                }
                column(LongDescription_Line; "Long Description")
                {
                }
                column(SCS_UnitOfMeasure_Lbl; Text_SCS_UnitOfMeasure_Short_Lbl)
                {
                }
                column(SCS_WorkTypeCode_Line_Lbl; Text_SCS_WorkTypeCode_Line_Lbl)
                {
                }
                column(WorkTypeCode_Line; "Work Type Code")
                {
                }
                column(PrintBold_Line; PrintBold)
                {
                }
                column(PrintItalics_Line; PrintItalics)
                {
                }
                column(PrintIndented_Line; PrintIndented)
                {
                }
                column(SCS_Quantity_Line_Lbl; Text_SCS_Quantity_Line_Lbl)
                {
                }
                column(SCS_UnitPrice_Lbl; Text_SCS_UnitPrice_Lbl)
                {
                }
                column(SCS_LineAmount_Line_Lbl; Text_SCS_LineAmount_Line_Lbl)
                {
                }
                column(UnitOfMeasureCode_Line; "Unit of Measure Code")
                {
                }
                column(SCS_EstimationPrecisionClass_Lbl; Text_SCS_EstimationPrecisionClass)
                {
                }
                column(SCS_EstimationPrecisionClass_Line; Format("Estimation (Precision) Class"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PostedShipmentDate := 0D;

                    if Type = Type::"G/L Account" then
                        "No." := '';

                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := StrSubstNo('%1%', -Round("Line Discount %", 0.1));

                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    if FirstLineHasBeenOutput then
                        Clear(CompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;

                    // SCSINV1.00 24.11.15 CBO +++
                    if Type <> Type::" " then begin
                        gIsReverseCharge := gIsReverseCharge or ("VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT");
                        gIsNotReverseCharge := gIsNotReverseCharge or ("VAT Calculation Type" <> "VAT Calculation Type"::"Reverse Charge VAT");

                        if gIsReverseCharge and gIsNotReverseCharge then
                            Error(TextReverseChargeCannotBeMixed);
                    end;
                    // SCSINV1.00 24.11.15 CBO ---
                end;

                trigger OnPreDataItem()
                begin
                    MoreLines := Find('+');
                    // WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO // --- SCSINV1.00
                    while MoreLines and (Description = '') and ("Long Description" = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do // +++ SCSINV1.00
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.break;
                    SetRange("Line No.", 0, "Line No.");
                    // to do CreateTotals code is deprecated
                    //CurrReport.CreateTotals("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    FirstLineHasBeenOutput := false;
                    CompanyInfo.CalcFields(Picture);
                end;
            }
            dataitem(VATAmountLine; "VAT Amount Line")
            {
                DataItemTableView = sorting("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(InvoiceDiscountAmount_VATAmountLine; "Invoice Discount Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountAmount_VATAmountLine_Lbl; FieldCaption("Invoice Discount Amount"))
                {
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine; "Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine_Lbl; FieldCaption("Inv. Disc. Base Amount"))
                {
                }
                column(LineAmount_VatAmountLine; "Line Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_VatAmountLine_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(VATAmount_VatAmountLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmount_VatAmountLine_Lbl; FieldCaption("VAT Amount"))
                {
                }
                column(VATAmountLCY_VATAmountLine; VATAmountLCY)
                {
                }
                column(VATAmountLCY_VATAmountLine_Lbl; VATAmountLCYLbl)
                {
                }
                column(VATBase_VatAmountLine; "VAT Base")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATBase_VatAmountLine_Lbl; FieldCaption("VAT Base"))
                {
                }
                column(VATBaseLCY_VATAmountLine; VATBaseLCY)
                {
                }
                column(VATBaseLCY_VATAmountLine_Lbl; VATBaseLCYLbl)
                {
                }
                column(VATIdentifier_VatAmountLine; "VAT Identifier")
                {
                }
                column(VATIdentifier_VatAmountLine_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_VatAmountLine; "VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(VATPct_VatAmountLine_Lbl; FieldCaption("VAT %"))
                {
                }
                column(NoOfVATIdentifiers; Count)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VATBaseLCY :=
                        GetBaseLCY(
                            Header."Posting Date", Header."Currency Code",
                            Header."Currency Factor");
                    VATAmountLCY :=
                        GetAmountLCY(
                            Header."Posting Date", Header."Currency Code",
                            Header."Currency Factor");

                    TotalVATBaseLCY += VATBaseLCY;
                    TotalVATAmountLCY += VATAmountLCY;
                end;

                trigger OnPreDataItem()
                begin
                    // to do CreateTotals code is deprecated
                    /*CurrReport.CreateTotals(
                        "Line Amount", "Inv. Disc. Base Amount",
                        "Invoice Discount Amount", "VAT Base", "VAT Amount",
                        VATBaseLCY, VATAmountLCY);
                    */
                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
                end;
            }
            dataitem(ReportTotalsLine; "Report Totals Buffer")
            {
                DataItemTableView = sorting("Line No.");
                UseTemporary = true;
                column(Description_ReportTotalsLine; Description)
                {
                }
                column(Amount_ReportTotalsLine; Amount)
                {
                }
                column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                {
                }
                column(FontBold_ReportTotalsLine; "Font Bold")
                {
                }
                column(FontUnderline_ReportTotalsLine; "Font Underline")
                {
                }

                trigger OnPreDataItem()
                begin
                    CreateReportTotalLines;
                end;
            }
            dataitem(Totals; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(TotalNetAmount; TotalAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATBaseLCY; TotalVATBaseLCY)
                {
                }
                column(TotalAmountIncludingVAT; TotalAmountInclVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATAmount; TotalAmountVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATAmountLCY; TotalVATAmountLCY)
                {
                }
                column(TotalInvoiceDiscountAmount; TotalInvDiscAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalPaymentDiscountOnVAT; TotalPaymentDiscOnVAT)
                {
                }
                column(TotalVATAmountText; VATAmountLine.VATAmountText)
                {
                }
                column(TotalExcludingVATText; TotalExclVATText)
                {
                }
                column(TotalIncludingVATText; TotalInclVATText)
                {
                }
                column(TotalSubTotal; TotalSubTotal)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalSubTotalMinusInvoiceDiscount; TotalSubTotal + TotalInvDiscAmount)
                {
                }
                column(TotalText; TotalText)
                {
                }
                column(SCSINV100_NewFields_Totals; '***SCSINV1.00***')
                {
                }
                column(SCS_SingleVATPerc_Lbl; StrSubstNo(Text_SCS_SingleVATPerc_Lbl, VATAmountLine."VAT %"))
                {
                }
                column(SCS_SingleVATBase; VATAmountLine."VAT Base")
                {
                }
                column(SCS_LinesTotal; Text_SCS_LinesTotal)
                {
                }
                column(SCS_TotalBeforeVAT; Text_SCS_TotalBeforeVAT)
                {
                }
                column(SCS_GrandTotal; Text_SCS_GrandTotal)
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                ArchiveManagement: Codeunit ArchiveManagement;
                SalesPost: Codeunit "Sales-Post";
            begin
                Clear(Line);
                Clear(SalesPost);
                VATAmountLine.DeleteAll;
                Line.DeleteAll;
                SalesPost.GetSalesLines(Header, Line, 0);
                Line.CalcVATAmountLines(0, Header, Line, VATAmountLine);
                Line.UpdateVATOnLines(0, Header, Line, VATAmountLine);

                if not CurrReport.Preview then
                    Codeunit.Run(Codeunit::"Sales-Printed", Header);

                CurrReport.Language := Language.GetLanguageID("Language Code");
                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                        Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                if "Salesperson Code" = '' then begin
                    SalespersonPurchaser.Init;
                    SalesPersonText := '';
                end else begin
                    SalespersonPurchaser.Get("Salesperson Code");
                    SalesPersonText := SalespersonLbl;
                end;
                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    // SCSINV1.00 +++
                    if GLSetup."Local Currency Symbol" <> '' then
                        // override with symbol
                        GLSetup."LCY Code" := GLSetup."Local Currency Symbol";
                    // SCSINV1.00 ---
                    TotalText := StrSubstNo(TotalTextLbl, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(TotalInclVATTextLbl, GLSetup."LCY Code");
                    TotalExclVATText := StrSubstNo(TotalExclVATTextLbl, GLSetup."LCY Code");
                    gCurrencyFormat := StrSubstNo(TextCurrencyFormat, GLSetup."LCY Code"); // SCSINV1.00 +++
                end else begin
                    TotalText := StrSubstNo(TotalTextLbl, "Currency Code");
                    TotalInclVATText := StrSubstNo(TotalInclVATTextLbl, "Currency Code");
                    TotalExclVATText := StrSubstNo(TotalExclVATTextLbl, "Currency Code");
                    gCurrencyFormat := StrSubstNo(TextCurrencyFormat, "Currency Code"); // SCSINV1.00 +++
                end;
                FormatAddr.SalesHeaderBillTo(CustAddr, Header);
                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init
                else begin
                    PaymentTerms.Get("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;

                if "Payment Method Code" = '' then
                    PaymentMethod.Init
                else
                    PaymentMethod.Get("Payment Method Code");

                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init
                else begin
                    ShipmentMethod.Get("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                end;

                //13.08.9 YSU +++
                //FormatAddr.SalesHeaderShipTo(ShipToAddr, Header);
                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, Header);
                //13.08.9 YSU ---
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                for i := 1 to ArrayLen(ShipToAddr) do
                    if ShipToAddr[i] <> CustAddr[i] then
                        ShowShippingAddr := true;

                if not CurrReport.Preview and ArchiveDocument then
                    ArchiveManagement.StoreSalesDocument(Header, LogInteraction);

                if LogInteraction and not CurrReport.Preview then begin
                    CalcFields("No. of Archived Versions");
                    if "Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                            1, "No.", "Doc. No. Occurrence",
                            "No. of Archived Versions", Database::Contact, "Bill-to Contact No.",
                            "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                    else
                        SegManagement.LogDocument(
                            1, "No.", "Doc. No. Occurrence",
                            "No. of Archived Versions", Database::Customer, "Bill-to Customer No.",
                            "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                end;

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;

                TestField("Quote Expiry Date");
                gSCS_QuoteExpirationTerms := StrSubstNo(Text_SCS_QuoteExpirationTerms, "Quote Expiry Date");
            end;

            trigger OnPreDataItem()
            begin
                FirstLineHasBeenOutput := false;
            end;
        }
    }

    requestpage
    {

        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = DEU = 'Optionen',
                                ENU = 'Options';
                    field(LogInteraction; LogInteraction)
                    {
                        CaptionML = DEU = 'Aktivität protokollieren',
                                    ENU = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        CaptionML = DEU = 'Beleg archivieren',
                                    ENU = 'Archive Document';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get;
        CompanyInfo.Get;
        SalesSetup.Get;
        CompanyInfo.VerifyAndSetPaymentInfo;
    end;

    trigger OnPreReport()
    begin
        if Header.GetFilters = '' then
            Error(NoFilterSetErr);

        if not CurrReport.UserequestPage then
            InitLogInteraction;

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var
        TotalTextLbl: TextConst DEU = 'Total %1', ENU = 'Total %1';
        TotalInclVATTextLbl: TextConst DEU = 'Total %1 inkl. MwSt.', ENU = 'Total %1 Incl. VAT';
        SalesConfirmationLbl: TextConst DEU = 'Angebot', ENU = 'Sales Quote';
        TotalExclVATTextLbl: TextConst DEU = 'Total %1 ohne MwSt.', ENU = 'Total %1 Excl. VAT';
        SalespersonLbl: TextConst DEU = 'Vertriebsmitarbeiter', ENU = 'Sales person';
        CompanyInfoBankAccNoLbl: TextConst DEU = 'Kontonr.', ENU = 'Account No.';
        CompanyInfoBankNameLbl: TextConst DEU = 'Bank', ENU = 'Bank';
        CompanyInfoGiroNoLbl: TextConst DEU = 'Postgirokontonr.', ENU = 'Giro No.';
        CompanyInfoPhoneNoLbl: TextConst DEU = 'Telefonnr.', ENU = 'Phone No.';
        CopyLbl: TextConst DEU = 'Kopieren', ENU = 'Copy';
        EMailLbl: TextConst DEU = 'E-Mail', ENU = 'Email';
        HomePageLbl: TextConst DEU = 'Homepage', ENU = 'Home Page';
        InvDiscBaseAmtLbl: TextConst DEU = 'Rechnungsrab.-Bem.grundlage', ENU = 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: TextConst DEU = 'Rechnungsrabatt', ENU = 'Invoice Discount';
        InvNoLbl: TextConst DEU = 'Angebotsnr.', ENU = 'Quote No.';
        LineAmtAfterInvDiscLbl: TextConst DEU = 'Skonto auf MwSt.', ENU = 'Payment Discount on VAT';
        LocalCurrencyLbl: TextConst DEU = 'Landeswährung', ENU = 'Local Currency';
        PageLbl: TextConst DEU = 'Seite', ENU = 'Page';
        PaymentTermsDescLbl: TextConst DEU = 'Zahlungsbedingungen', ENU = 'Payment Terms';
        PaymentMethodDescLbl: TextConst DEU = 'Zahlungsform', ENU = 'Payment Method';
        PostedShipmentDateLbl: TextConst DEU = 'Warenausg.-Datum', ENU = 'Shipment Date';
        SalesInvLineDiscLbl: TextConst DEU = 'Rabatt in %', ENU = 'Discount %';
        ShipmentLbl: TextConst DEU = 'Warenausgang', ENU = 'Shipment';
        ShiptoAddrLbl: TextConst DEU = 'Lief. an Adresse', ENU = 'Ship-to Address';
        ShptMethodDescLbl: TextConst DEU = 'Lieferbedingung', ENU = 'Shipment Method';
        SubtotalLbl: TextConst DEU = 'Zw.summe', ENU = 'Subtotal';
        TotalLbl: TextConst DEU = 'Gesamt', ENU = 'Total';
        VATAmtSpecificationLbl: TextConst DEU = 'MwSt.-Betrag - Spezifikation', ENU = 'VAT Amount Specification';
        VATAmtLbl: TextConst DEU = 'MwSt.-Betrag', ENU = 'VAT Amount';
        VATAmountLCYLbl: TextConst DEU = 'MwSt.-Betrag (MW)', ENU = 'VAT Amount (LCY)';
        VATBaseLbl: TextConst DEU = 'MwSt.-Bemessungsgrundlage', ENU = 'VAT Base';
        VATBaseLCYLbl: TextConst DEU = 'MwSt.-Bemessungsgrundlage (MW)', ENU = 'VAT Base (LCY)';
        VATClausesLbl: TextConst DEU = 'MwSt.-Klausel', ENU = 'VAT Clause';
        VATIdentifierLbl: TextConst DEU = 'MwSt.-Kennzeichen', ENU = 'VAT Identifier';
        VATPercentageLbl: TextConst DEU = 'MwSt. %', ENU = 'VAT %';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        // to do this field is marked removed in BC15 so replacesd it with CU language
        // Language: Record Language; 
        Language: Codeunit Language;
        VATClause: Record "VAT Clause";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        LineDiscountPctText: Text;
        MoreLines: Boolean;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        ArchiveDocument: Boolean;
        i: Integer;
        LogInteraction: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TransHeaderAmount: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        CompanyLogoPosition: Integer;
        FirstLineHasBeenOutput: Boolean;
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        ExchangeRateTxt: TextConst DEU = 'Wechselkurs: %1/%2', ENU = 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        PrevLineAmount: Decimal;
        NoFilterSetErr: TextConst DEU = 'Sie müssen mindestens einen Filter angeben, um zu verhindern, dass versehentlich alle Belege gedruckt werden.', ENU = 'You must specify one or more filters to avoid accidently printing all documents.';
        "***SCSINV1.00 ***": Integer;
        gCurrencyFormat: Text;
        gIsReverseCharge: Boolean;
        gIsNotReverseCharge: Boolean;
        "*** SCSINV1.00 ***": TextConst;
        Text_SCS_UnitOfMeasure_Short_Lbl: TextConst DEU = 'ME', ENU = 'UN';
        Text_SCS_WorkTypeCode_Line_Lbl: TextConst DEU = 'Art', ENU = 'Type';
        Text_SCS_Quantity_Line_Lbl: TextConst DEU = 'Menge', ENU = 'Qty';
        Text_SCS_UnitPrice_Lbl: TextConst DEU = 'Preis', ENU = 'Price';
        Text_SCS_LineAmount_Line_Lbl: TextConst DEU = 'Betrag', ENU = 'Amount';
        TextCurrencyFormat: Label '#,0.00 ''%1'';#,0.00- ''%1''';
        Text_SCS_SingleVATPerc_Lbl: TextConst DEU = 'Umsatzsteuer %1% auf', ENU = '%1% VAT on';
        Text_SCS_LinesTotal: TextConst DEU = 'Summe', ENU = 'Total';
        Text_SCS_TotalBeforeVAT: TextConst DEU = 'Summe', ENU = 'Total';
        Text_SCS_GrandTotal: TextConst DEU = 'Gesamtbetrag', ENU = 'Grand Total';
        Text_SCS_SalesPerson_Lbl: TextConst DEU = 'Kontakt', ENU = 'Contact';
        TextReverseChargeCannotBeMixed: TextConst DEU = 'Einige, aber nicht alle USt.-Zeilen sind als "Erwerbsbesteuerung" gekennzeichnet. Erwerbsbesteuerung kann nicht mit anderen USt.-Arten gemischt werden.', ENU = 'Some but not all VAT lines of this invoice are marked "Reverse Charge". "Reverse Charge" lines cannot be mixed with other VAT lines.';
        gSCS_QuoteExpirationTerms: Text;
        Text_SCS_QuoteExpirationTerms: TextConst DEU = 'An dieses Angebot halten wir uns bis zum %1 gebunden.', ENU = 'This quote expires after %1.';
        Text_SCS_EstimationPrecisionClass: TextConst DEU = 'Schätz-Genauigkeits-klasse', ENU = 'Est. Precision Class';

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        exit(SalesConfirmationLbl);
    end;

    procedure InitializeRequest(NewLogInteraction: Boolean)
    begin
        LogInteraction := NewLogInteraction;
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll;
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
            if TotalAmountVAT <> 0 then
                ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then
            ReportTotalsLine.Add(VATAmountLine.VATAmountText, TotalAmountVAT, false, true, false);
    end;
}

