pageextension 50120 "SCSINVTEMPO - Customer Setup" extends "TEMPO - Customer Setup"
{
    layout
    {
        addlast(content)
        {

            field(QtyBaseFractionMin; "Qty. (Base) Fraction (min)")
            {
                ApplicationArea = All;
            }
            field(GroupByJob; "Group by Job")
            {
                ApplicationArea = All;
            }
            field(UseDefaultWorkType; "Use Default Work Type")
            {
                ApplicationArea = All;
            }
            field(DefaultWorkType; "Default Work Type")
            {
                ApplicationArea = All;
            }
            field(InvHeaderTempl; "Inv. Header Templ.")
            {
                ApplicationArea = All;
            }
            field(InvLineTemplJob; "Inv. Line Templ. Job")
            {
                ApplicationArea = All;
            }
            field(InvLineTemplRessource; "Inv. Line Templ. Ressource")
            {
                ApplicationArea = All;
            }
            field(InvLineTemplGLAccount; "Inv. Line Templ. G/L Account")
            {
                ApplicationArea = All;
            }
            field(GLAccountForExpenses; "G/L Account for Expenses")
            {
                ApplicationArea = All;
            }
            field(UnitForExpenses; "Unit for Expenses")
            {
                ApplicationArea = All;
            }
            field(ConsolidateGLAccLines; "Consolidate G/L-Acc. Lines")
            {
                ApplicationArea = All;
            }
            field(TemplateWorkbook; "Template Workbook")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    FileMgmt: Codeunit "File Management";
                    Filename: Text;
                begin
                    FileName := FileMgmt.OpenFileDialog(TextSelectWorkbook, '', '');

                    if "Filename Template" = '' then
                        Error('');

                    "Template Workbook" := FileName;
                end;

                trigger OnValidate()
                var
                    FileMgmt: Codeunit "File Management";
                begin
                    if not FileMgmt.ClientFileExists("Template Workbook") then
                        Error(TextWorkbookNotFound);

                end;
            }
            field(TargetFolder; "Target Folder")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    exit(BrowseFolder(Text, "Target Folder", FieldCaption("Target Folder")));
                end;
            }
            field(FilenameTemplate; "Filename Template")
            {
                ApplicationArea = All;
            }

        }


    }



    var
        TextWorkbookNotFound: TextConst DEU = 'Die Vorlagenarbeitsmappe %1 konnte nicht gefunden werden.', ENU = 'The template workbook %1 could not be found.';
        TextSelectFolder: TextConst DEU = 'Bitte ein Verzeichnis auswählen', ENU = 'Please select a folder.';
        TextSelectWorkbook: TextConst DEU = 'Bitte eine Vorgabe-Arbeitsmappe auswählen.', ENU = 'Please select a template workbook.';

    local procedure BrowseFolder(var FolderName: Text; CurrentValue: Text; FieldCaption: Text): Boolean
    var
        FileMgt: Codeunit "File Management";
    begin
        if not CurrPage.Editable then
            exit;

        FolderName := FileMgt.BrowseForFolderDialog(StrSubstNo(TextSelectFolder, FieldCaption), CurrentValue, true);
        exit(FolderName <> '');
    end;
}

