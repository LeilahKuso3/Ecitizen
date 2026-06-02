table 50110 "CSD Seminar Reg. Header"
// CSD1.00 - 2018-01-01 - D. E. Veloper 
//   Chapter 6 - Lab 1 
//     - Created new table 
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
            trigger OnValidate()
            begin
                if "Starting Date" <> xRec."Starting Date" then
                    TestField(Status, Status::Planning);
            end;
        }

        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = "CSD Seminar";
            trigger OnValidate()
            begin
                if "Seminar No." <> xRec."Seminar No." then begin

                    SeminarRegLine.Reset();
                    SeminarRegLine.SetRange("Document No.", "No.");

                    if SeminarRegLine.FindFirst() then
                        Error('You cannot change Seminar No. because lines already exist.');

                    Seminar.Get("Seminar No.");
                    Seminar.TestField(Blocked, false);

                    "Seminar Name" := Seminar.Name;
                    Duration := Seminar."Seminar Duration";
                    "Seminar Price" := Seminar."Seminar Price";
                end;
            end;
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
            CalcFormula = lookup(Resource.Name WHERE("No." = FIELD("Instructor Resource No."),
Type = CONST(Person)));
            Editable = false;
            FieldClass = FlowField;
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
            trigger OnValidate()
            var
                SeminarRegLine: Record "CSD Seminar Reg. Line";
            begin
                if ("Seminar Price" <> xRec."Seminar Price") and
                   (Status <> Status::Canceled) then begin

                    SeminarRegLine.Reset();
                    SeminarRegLine.SetRange("Document No.", "No.");
                    SeminarRegLine.SetRange(Registered, false);

                    if SeminarRegLine.FindSet() then
                        if Confirm('Update price for all lines?') then
                            repeat
                                SeminarRegLine.Validate("Seminar Price", Rec."Seminar Price");
                                SeminarRegLine.Modify();
                            until SeminarRegLine.Next() = 0;
                end;
            end;
        }

        field(15; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }

        field(16; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
            trigger OnValidate()
            begin
                if "Posting No. Series" <> '' then begin
                    SeminarSetup.Get();
                    SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                end;
            end;
        }

        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        SeminarSetup: Record "CSD Seminar Setup";
        NoSeriesMgt: Codeunit "No. Series";
        Seminar: Record "CSD Seminar";
        SeminarRoom: Record Resource;
        SeminarRegLine: Record "CSD Seminar Reg. Line";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.Get();

            SeminarSetup.TestField("Seminar Registration Nos.");

            "No." := NoSeriesMgt.GetNextNo(
                SeminarSetup."Seminar Registration Nos.");

            "Posting Date" := WorkDate();
            "Document Date" := WorkDate();
        end;
    end;

    trigger OnDelete()
    var
        SeminarRegLine: Record "CSD Seminar Reg. Line";
        SeminarCommentLine: Record "CSD Seminar Comment Line";
    begin
        if (CurrFieldNo > 0) then
            TestField(Status, Status::Canceled);

        SeminarRegLine.Reset();
        SeminarRegLine.SetRange("Document No.", "No.");
        SeminarRegLine.SetRange(Registered, true);

        if SeminarRegLine.FindFirst() then
            Error('You cannot delete a registration with registered participants.');

        SeminarRegLine.SetRange(Registered);
        SeminarRegLine.DeleteAll(true);

        SeminarCommentLine.Reset();
        SeminarCommentLine.SetRange(
    "Table Name",
    SeminarCommentLine."Table Name"::SeminarRegistrationHeader);
        SeminarCommentLine.SetRange("No.", "No.");
        SeminarCommentLine.DeleteAll();
    end;

    local procedure InitRecord()
    begin
        if "Posting Date" = 0D then
            "Posting Date" := WorkDate();

        if "Document Date" = 0D then
            "Document Date" := WorkDate();

        SeminarSetup.Get();
    end;

    procedure AssistEdit(OldSeminarRegHeader: Record "CSD Seminar Reg. Header"): Boolean
    var
        SeminarSetup: Record "CSD Seminar Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Registration Nos.");

        if OldSeminarRegHeader."No. Series" <> '' then begin
            "No. Series" := OldSeminarRegHeader."No. Series";
            exit(true);
        end;
    end;
}

table 50112 "CSD Seminar Reg. Line"
{
    Caption = 'CSD Seminar Reg. Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }

        field(2; Registered; Boolean)
        {
            Caption = 'Registered';
        }

        field(3; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 1;
        }
    }

    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }
}

