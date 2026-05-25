table 50108 Students
{
    Caption = 'Students';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; RegNo; Code[30])
        {
            Caption = 'RegNo';
        }
        field(2; MyField; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; RegNo)
        {
            Clustered = true;
        }
    }
}
