table 50117 "Passport Application Header"
{
    Caption = 'Passport Application Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }

        field(2; "Applicant ID No."; Code[20])
        {
            Caption = 'Applicant ID No.';
        }

        field(3; "First Name"; Text[50])
        {
            Caption = 'First Name';
        }

        field(4; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }

        field(5; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
        }

        field(6; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }

        field(7; "Email"; Text[80])
        {
            Caption = 'Email';
        }

        field(8; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }

        field(9; Status; Option)
        {
            OptionMembers = Open,Submitted,UnderReview,Approved,Rejected,Issued;
            Caption = 'Status';
        }

        field(10; "Passport Type"; Option)
        {
            OptionMembers = "32 Pages","48 Pages","64 Pages";
            Caption = 'Passport Type';
            trigger OnValidate()
            begin
                case "Passport Type" of
                    "Passport Type"::"32 Pages":
                        Amount := 4550;

                    "Passport Type"::"48 Pages":
                        Amount := 6050;

                    "Passport Type"::"64 Pages":
                        Amount := 7550;
                end;
            end;
        }

        field(11; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
        field(12; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(20; "Completion %"; Decimal)
        {
            Caption = 'Completion %';
            Editable = false;
        }
        // =========================
// 👤 ADDITIONAL PERSONAL INFO
// =========================
field(21; "Place of Birth"; Text[100])
{
    Caption = 'Place of Birth';
}

field(22; Occupation; Text[100])
{
    Caption = 'Occupation';
}

field(23; "Employment Status"; Option)
{
    Caption = 'Employment Status';
    OptionMembers = Employed,Unemployed,Student,SelfEmployed;
}

field(24; Religion; Text[50])
{
    Caption = 'Religion';
}

// =========================
// =========================
field(25; "Emergency Contact Name"; Text[100])
{
    Caption = 'Emergency Contact Name';
}

field(26; "Emergency Contact Phone"; Text[30])
{
    Caption = 'Emergency Contact Phone';
}

field(27; "Emergency Contact Relationship"; Text[50])
{
    Caption = 'Relationship';
}

field(28; "Emergency Contact Address"; Text[100])
{
    Caption = 'Address';
}
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";
        PassportSetup: Record "Passport Setup";
    begin
        if "No." = '' then begin
            PassportSetup.Get('SETUP');
            PassportSetup.TestField("Passport Application Nos.");

            "No." := NoSeriesMgt.GetNextNo(
                PassportSetup."Passport Application Nos.",
                Today);
        end;

        if "Application Date" = 0D then
            "Application Date" := Today;

        Status := Status::Open;
    end;

    procedure UpdateCompletionPercentage()
    var
        PassportDocument: Record "Passport Document Line";
        TotalDocs: Integer;
        SubmittedDocs: Integer;
    begin
        PassportDocument.SetRange("Application No.", "No.");

        TotalDocs := PassportDocument.Count();

        PassportDocument.SetRange(Submitted, true);
        SubmittedDocs := PassportDocument.Count();

        if TotalDocs > 0 then
            "Completion %" := Round((SubmittedDocs * 100) / TotalDocs, 1)
        else
            "Completion %" := 0;
    end;

}