page 50130 "Passport Setup"
{
    PageType = Card;
    SourceTable = "Passport Setup";

    Caption = 'Passport Setup';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Passport Application Nos."; Rec."Passport Application Nos.")
                {
                    ApplicationArea = All;
                }

                field("Posted Passport Nos."; Rec."Posted Passport Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get('SETUP') then begin
            Rec.Init();
            Rec."Primary Key" := 'SETUP';
            Rec.Insert();
        end;
    end;
}