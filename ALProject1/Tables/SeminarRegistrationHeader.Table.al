table 50110 "CSD Seminar Reg. Header"
{
    Caption = 'Seminar Registration Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }

        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }

        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = "CSD Seminar";
        }

        field(4; "Seminar Name"; Text[100])
        {
            Caption = 'Seminar Name';
        }

        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Planning,Registration,Closed,Canceled;
        }
        field(6; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}