table 50118 "CSD Posted Seminar Reg. Header"

// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 3-1
{
    Caption = 'Posted Seminar Reg. Header';
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

        field(7; "Instructor Resource No."; Code[20])
        {
            Caption = 'Instructor Resource No.';
            TableRelation = Resource WHERE(Type = CONST(Person));
        }

        field(8; "Instructor Name"; Text[100])
        {
            Caption = 'Instructor Name';
            FieldClass = FlowField;

            CalcFormula = lookup(Resource.Name WHERE(
            "No." = FIELD("Instructor Resource No."),
            Type = CONST(Person)));

            Editable = false;
        }

        field(9; "Room Resource No."; Code[20])
        {
            Caption = 'Room Resource No.';
            TableRelation = Resource;
        }

        field(10; "Room Name"; Text[100])
        {
            Caption = 'Room Name';
        }

        field(11; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }

        field(12; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }

        field(13; Duration; Decimal)
        {
            Caption = 'Duration';
            DecimalPlaces = 0 : 1;
        }

        field(14; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 1;
        }

        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }

        field(22; Comment; Boolean)
        {
            Caption = 'Comment';
            FieldClass = FlowField;

            // Removed Table Name filter because the option value caused a compile error
            CalcFormula = Exist("CSD Seminar Comment Line" WHERE(
            "No." = FIELD("No.")
            ));

            Editable = false;
        }

        field(29; "User Id"; Code[50])
        {
            Caption = 'User Id';
            TableRelation = User;
            ValidateTableRelation = false;
        }

        field(30; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
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
