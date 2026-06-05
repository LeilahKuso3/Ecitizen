table 50118 "Passport Document Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(2; "Application No."; Code[20])
        {
            TableRelation = "Passport Application Header"."No.";
        }

        field(3; "Document Type"; Option)
        {
            OptionMembers = "National ID","Birth Certificate","Passport Photo","Application Form","Other";
        }

        field(4; Description; Text[100]) { }

        field(5; Submitted; Boolean) { }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }
    trigger OnInsert()
    var
        PassportApplication: Record "Passport Application Header";
    begin
        if PassportApplication.Get("Application No.") then begin
            PassportApplication.UpdateCompletionPercentage();
            PassportApplication.Modify();
        end;
    end;

    trigger OnModify()
    var
        PassportApplication: Record "Passport Application Header";
    begin
        if PassportApplication.Get("Application No.") then begin
            PassportApplication.UpdateCompletionPercentage();
            PassportApplication.Modify();
        end;
    end;

    trigger OnDelete()
    var
        PassportApplication: Record "Passport Application Header";
    begin
        if PassportApplication.Get("Application No.") then begin
            PassportApplication.UpdateCompletionPercentage();
            PassportApplication.Modify();
        end;
    end;
}