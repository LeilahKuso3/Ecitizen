table 50111 "CSD Seminar Registration Line"
{
    Caption = 'Seminar Registration Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "CSD Seminar Reg. Header";
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