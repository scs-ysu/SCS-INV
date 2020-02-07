pageextension 50122 "SCSINVAttachments" extends "SCSJIFAttachments"
{
    //to do please check with SCSJIF attachement page and remove what is unwanted
    var
        gRecordId: RecordID;
        gAttachedToRecordId: Text;
        TXT_OutputName_INV: TextConst DEU = 'C:\\temp\\SCS Bohnsack & Thedinga GmbH - Rechnung %1 mit Anhang.pdf', ENU = 'C:\\temp\\SCS Bohnsack & Thedinga GmbH - Invoice %1 and attachments.pdf';
        TXT_OutputName_CM: TextConst DEU = 'C:\\temp\\SCS Bohnsack & Thedinga GmbH - Gutschrift %1 mit Anhang.pdf', ENU = 'C:\\temp\\SCS Bohnsack & Thedinga GmbH - Credit Memo %1 and attachments.pdf';
        TXT_NoPDFAttachmentsFound: TextConst DEU = 'Keine .PDF-Anhänge gefunden.', ENU = 'No attachments of type .PDF found.';
        Txt_AttachmentDataMissing: TextConst DEU = 'Keine Daten für den Anhang gefunden.', ENU = 'No attachment data found.';
        Mail: Codeunit Mail;
        Customer: Record Customer;
        TXT_Subject: TextConst DEU = 'PDF-Rechnung %2 für %1', ENU = 'PDF-Invoice %2 for %1.';
        TXT_MailBody: TextConst DEU = 'Im Anhang unsere Rechnung.', ENU = 'Attached please find our invoice.';


    procedure PrintInvoiceAndAttachPDFs(SalesInvHeader: Record "Sales Invoice Header")
    var
        ServerTempFileName: Text;
        OutputFileName: Text;
        FileMgt: Codeunit "File Management";
    begin

        SetRange("Attached to Record Id", SalesInvHeader.RecordId);
        SetFilter(FileName, '@*.Pdf');

        if not FindFirst then
            Error(TXT_NoPDFAttachmentsFound);

        // Create the PDF to a temporary file on the NAV server
        ServerTempFileName := FileMgt.ServerTempFileName('pdf');
        SalesInvHeader.SetRecFilter;

        Report.SaveAsPdf(Report::"SCSINV Sales - Invoice", ServerTempFileName, SalesInvHeader);
        OutputFileName := StrSubstNo(TXT_OutputName_INV, SalesInvHeader."No.");

        PrintAndAttach(ServerTempFileName, OutputFileName);
    end;

    procedure PrintCreditMemoAndAttachPDFs(var SalesCreditMemoHeader: Record "Sales Cr.Memo Header")
    var
        ServerTempFileName: Text;
        OutputFileName: Text;
        FileMgt: Codeunit "File Management";
    begin

        SetRange("Attached to Record Id", SalesCreditMemoHeader.RecordId);
        SetFilter(FileName, '@*.Pdf');

        if not FindFirst then
            Error(TXT_NoPDFAttachmentsFound);

        // Create the PDF to a temporary file on the NAV server
        ServerTempFileName := FileMgt.ServerTempFileName('pdf');
        SalesCreditMemoHeader.SetRecFilter;

        Report.SaveAsPdf(Report::"SCSINV Credit Memo", ServerTempFileName, SalesCreditMemoHeader);
        OutputFileName := StrSubstNo(TXT_OutputName_CM, SalesCreditMemoHeader."No.");

        PrintAndAttach(ServerTempFileName, OutputFileName);
    end;

    local procedure PrintAndAttach(var ServerTempFileName: Text; var OutputFileName: Text)
    var
        OutputPdfDocument: DotNet PdfDocument;
        PdfReader: DotNet PdfReader;
        InputPdfDocument: DotNet PdfDocument;
        PdfPage: DotNet PdfPage;
        PdfDocumentOpenMode: DotNet PdfDocumentOpenMode;
        ServerTempFileName1: Text;
        ClientTempFileName: Text;
        i: Integer;
        BlobInStream: InStream;
        BlobOutStream: OutStream;
        //TempBlob: Record TempBlob;
        TempBlob: Codeunit "Temp Blob";
        FileMgt: Codeunit "File Management";
    begin

        OutputPdfDocument := PdfReader.Open(ServerTempFileName);

        repeat

            CalcFields(Attachment);
            if not Attachment.HasValue then
                Error(Txt_AttachmentDataMissing);

            ServerTempFileName1 := FileMgt.ServerTempFileName('pdf');

            // since Tempbolb record is missing and instead used "temp blob" code unit, added below 3 lines.
            //TempBlob.Blob := Attachment; 
            Attachment.CreateInStream(BlobInStream);
            TempBlob.CreateOutStream(BlobOutStream);
            CopyStream(BlobOutStream, BlobInStream);
            FileMgt.BLOBExportToServerFile(TempBlob, ServerTempFileName1);

            InputPdfDocument := PdfReader.Open(ServerTempFileName1, PdfDocumentOpenMode.Import);
            for i := 0 to InputPdfDocument.Pages.Count - 1 do begin
                PdfPage := InputPdfDocument.Pages.Item(i);
                OutputPdfDocument.AddPage(PdfPage);
            end;
        until Next() = 0;

        OutputPdfDocument.Save(ServerTempFileName);
        ClientTempFileName := FileMgt.DownloadTempFile(ServerTempFileName);

        FileMgt.MoveFile(ClientTempFileName, OutputFileName);

        /*
        if SalesInvHeader."Bill-to Customer No." <> '' then
            Customer.Get(SalesInvHeader."Bill-to Customer No.")
        else
            Customer.Get(SalesInvHeader."No.");

        Mail.NewMessageAsync(Customer."E-Mail for PDF Invoice", Customer."E-Mail", '', StrSubstNo(TXT_Subject, SalesInvHeader."Bill-to Name", SalesInvHeader."No."), TXT_MailBody, OutputFileName, true);
        */
    end;
}

