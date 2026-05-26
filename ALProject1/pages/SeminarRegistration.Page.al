page 50110 "CSD Seminar Registration"
{
    PageType = Document;
    SourceTable = "CSD Seminar Reg. Header";
    Caption = 'Seminar Registration';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }

                field("Starting Date"; Rec."Starting Date") { ApplicationArea = All; }

                field("Seminar No."; Rec."Seminar No.") { ApplicationArea = All; }

                field("Seminar Name"; Rec."Seminar Name") { ApplicationArea = All; }

                field(Status; Rec.Status) { ApplicationArea = All; }
            }

            part(Lines; "CSD Seminar Reg. Subpage")
            {
                ApplicationArea = All;
                Caption = 'Lines';
                SubPageLink = "Document No." = field("No.");
            }
        }

        area(FactBoxes)
        {
            part("Seminar Details FactBox"; "CSD Seminar Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Seminar No.");
            }

            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Bill-to Customer No.");
            }
        }
    }
}