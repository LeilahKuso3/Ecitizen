page 50118 "Passport Document Subpage"
{
    PageType = ListPart;
    SourceTable = "Passport Document Line";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type") { }
                field(Description; Rec.Description) { }
                field(Submitted; Rec.Submitted) { }
            }
        }
    }
}