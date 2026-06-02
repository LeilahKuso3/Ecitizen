tableextension 50103 CSDResourceLedgerEntryExt extends "Res. Ledger Entry"
// CSD1.00 - 2018-01-01 - D. E. Veloper 
// Chapter 7 - Lab 4-1 
{
    fields
    {
        field(50100; "Seminar Document No."; Code[20])
        {
            Caption = 'Seminar Document No.';
            TableRelation = "CSD Seminar";
        }
        field(50101; "CSD Seminar Registration No."; code[20])
        {
            Caption = 'Seminar Registration No.';
            TableRelation = "CSD Seminar Reg. Header";
        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}