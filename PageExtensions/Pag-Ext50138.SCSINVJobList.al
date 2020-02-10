pageextension 50138 "SCSINV Job List" extends "Job List"
{

    actions
    {
        // Add changes to page actions here
        addafter("&Statistics")
        {
            action(SCSExcelTimesheet)
            {
                ApplicationArea = All;
                Caption = 'Excel Timesheet';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    JobPlanningLine: Record "Job Planning Line";
                begin
                    TestField("Bill-to Customer No.");
                    TestField("Job Posting Group");
                    JobPlanningLine.SetRange("Bill-to Customer No.", "Bill-to Customer No.");
                    JobPlanningLine.SetRange("Job Posting Group", "Job Posting Group");
                    Report.RunModal(Report::"SCSINVCreate Excel Timesheet", true, false, JobPlanningLine);
                end;
            }

        }

    }


}