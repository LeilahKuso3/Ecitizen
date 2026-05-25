table 50101 "CSD Seminar"
{
    Caption = 'CSD Seminar';
    DataClassification = CustomerContent;
    LookupPageID = "CSD Seminar List";
    DrillDownPageID = "CSD Seminar List";

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeminarSetup.Get();
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end;
            end;
        }

        field(20; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or
                   ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }

        field(30; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DecimalPlaces = 0 : 1;
        }

        field(40; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }

        field(50; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }

        field(60; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }

        field(70; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }

        field(80; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }

        field(90; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
        }

        field(100; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 1;
        }

        field(110; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }

        // field(120; "VAT Prod. Posting Group"; Code[10])
        // {
        //     Caption = 'VAT Prod. Posting Group';
        //     TableRelation = "VAT Prod. Posting Group";
        // }

        field(130; "No. Series"; Code[20])
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

        key(Key1; "Search Name")
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Nos.");

            "No." := NoSeriesMgt.GetNextNo(
                SeminarSetup."Seminar Nos.",
                Today,
                true);

            "No. Series" := SeminarSetup."Seminar Nos.";
        end;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    var
        SeminarSetup: Record "CSD Seminar Setup";
        Seminar: Record "CSD Seminar";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit "No. Series";

    procedure AssistEdit(): Boolean
    begin
        Seminar := Rec;

        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Nos.");

        if NoSeriesMgt.LookupRelatedNoSeries(
            SeminarSetup."Seminar Nos.",
            xRec."No. Series",
            Seminar."No. Series")
        then begin
            Seminar."No." := NoSeriesMgt.GetNextNo(
                Seminar."No. Series");

            Rec := Seminar;
            exit(true);
        end;

        exit(false);
    end;
}

