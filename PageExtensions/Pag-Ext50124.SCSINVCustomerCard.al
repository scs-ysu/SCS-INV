pageextension 50124 "SCSINVCustomer Card" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sales This Year")
        {

            group(SCSJobsAndInvoicing)
            {
                CaptionML = DEU = 'SCS Projekte und Fakturierung',
                            ENU = 'SCS Jobs and Invoicing';
                field(QtyBaseFractionMin; "Qty. (Base) Fraction (min)")
                {
                    ApplicationArea = All;
                }
                field(GroupByJob; "Group by Job")
                {
                    ApplicationArea = All;
                }
                field(InvHeaderTempl; "Inv. Header Templ.")
                {
                    ToolTipML = DEU = 'Rechnungskopftext. Es können folgende Variablen benutzt werden: %1 (Leistungsdatum ab), %2 (Leistungsdatum bis)',
                                ENU = 'Invoice Header Text';
                    ApplicationArea = All;
                }
                field(InvLineTemplJob; "Inv. Line Templ. Job")
                {
                    ToolTip = 'Schablone für Rechnungszeilen - Projektüberschrift. Es können folgende Variablen benutzt werden: %1 (Projekt), %2 (Projekt Beschreibung)"';
                    ApplicationArea = All;
                }
                field(InvLineTemplRessource; "Inv. Line Templ. Ressource")
                {
                    ToolTip = 'Schablone für Rechnungszeilen - Ressourcen-Zeile. Es können folgende Variablen benutzt werden: %1 (Projekt), %2 (Projekt Beschreibung), %3 (Aufgabe), %4 (Beschreibung Aufgabe), %5 (Arbeitstyp)"';
                    ApplicationArea = All;
                }
                field(InvLineTemplGLAccount; "Inv. Line Templ. G/L Account")
                {
                    Description = 'SCSINV1.00';
                    ToolTip = 'Schablone für Rechnungszeilen - Sachkonto-Zeile. Es können folgende Variablen benutzt werden: %1 (Projekt), %2 (Projekt Beschreibung), %3 (Aufgabe), %4 (Beschreibung Aufgabe), %5 (Beschreibung Job Zeile), %6 (Beschreibung2 Job Zeile), %7 (Beschreibung  Zeile), %8 (Beschreibung 2 Zeile), %9 (Langbeschreibung Zeile)"';
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
                field(ConsolidateGLAccLines; "Consolidate G/L-Acc. Lines")
                {
                    ApplicationArea = All;
                }
                field(EMailForPDFInvoice; "E-Mail for PDF Invoice")
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