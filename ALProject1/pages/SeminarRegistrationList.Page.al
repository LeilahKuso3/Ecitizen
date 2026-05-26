page 50113 "CSD Seminar Registration List"
{
    PageType = List;
    SourceTable = "CSD Seminar Reg. Header";
    CardPageId = "CSD Seminar Registration";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }

                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                }

                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}