page 50111 "CSD Seminar Reg. Subpage"
{
    PageType = ListPart;
    SourceTable = "CSD Seminar Registration Line";
    Caption = 'Registration Lines';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    ApplicationArea = All;
                }

                field("Participant Name"; Rec."Participant Name")
                {
                    ApplicationArea = All;
                }

                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}