page 50115 "CSD Seminar Details FactBox"
{
    PageType = CardPart;
    SourceTable = "CSD Seminar";
    Caption = 'Seminar Details FactBox';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Search Name"; Rec."Search Name") { ApplicationArea = All; }
                field("Seminar Duration"; Rec."Seminar Duration") { ApplicationArea = All; }
                field("Minimum Participants"; Rec."Minimum Participants") { ApplicationArea = All; }
                field("Maximum Participants"; Rec."Maximum Participants") { ApplicationArea = All; }
            }
        }
    }
}
