page 50139 "Passport Application List"
{
    PageType = List;
    SourceTable = "Passport Application Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Passport Application Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { }
                field("Applicant ID No."; Rec."Applicant ID No.") { }
                field("First Name"; Rec."First Name") { }
                field("Last Name"; Rec."Last Name") { }
                field("Passport Type"; Rec."Passport Type") { }
                field(Status; Rec.Status) { }
                field(Amount; Rec.Amount) { }
            }
        }
    }
}