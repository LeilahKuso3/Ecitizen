table 50130 "Passport Setup"
{
    Caption = 'Passport Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

        field(10; "Passport Application Nos."; Code[20])
        {
            Caption = 'Passport Application Nos.';
            TableRelation = Customer;
        }

        field(20; "Posted Passport Nos."; Code[20])
        {
            Caption = 'Posted Passport Nos.';
            TableRelation = Customer;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}