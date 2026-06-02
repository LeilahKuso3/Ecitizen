table 50104 "CSD Seminar Comment Line"
// CSD1.00 - 2018-01-01 - D. E. Veloper 
// Chapter 5 - Lab 2-1 
// Chapter 7 - Lab 3-2 
{
    Caption = 'Seminar Comment Line';
    LookupPageID = "CSD Seminar Comment List";
    DrillDownPageID = "CSD Seminar Comment List";

    fields
    {
        field(10; "Table Name"; Option)
        {
            Caption = 'Table Name';
            OptionMembers = Seminar,SeminarRegistrationHeader,PostedSeminarRegHeader;
            OptionCaption = 'Seminar,Seminar Registration Header,Posted Seminar Reg. Header';
        }
        field(20; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(30; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "CSD Seminar";
        }
        field(40; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(50; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(60; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(70; "Comment"; Text[80])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(PK; "Table Name", "Document Line No.", "No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
