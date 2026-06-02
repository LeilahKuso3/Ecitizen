table 50119 "CSD Posted Seminar Reg. Line"
// CSD1.00 - 2018-01-01 - D. E. Veloper 
// Chapter 7 - Lab 3-3 
{
    Caption = 'CSD Posted Seminar Reg. Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "CSD Posted Seminar Reg. Header";
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(3; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            TableRelation = Contact;
        }

        field(4; "Participant Name"; Text[100])
        {
            Caption = 'Participant Name';
        }

        field(5; Registered; Boolean)
        {
            Caption = 'Registered';
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}