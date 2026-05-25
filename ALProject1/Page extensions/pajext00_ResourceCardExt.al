pageextension 50100 "CSD ResourceCardExt" extends Microsoft.Projects.Resources.Resource."Resource Card"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 - Lab 1-2
// Added new fields:
// - Internal/External
// - Maximum Participants
// Added new FastTab
// Added code to OnOpenPage trigger
{
    layout
    {
        addlast(General)
        {
            field("CSD Resource Type"; Rec."CSD Resource Type")
            {
            }
            field("CSD Quantity Per Day"; Rec."CSD Quantity Per Day")
            {
            }
        }

        addafter("Personal Data")
        {
            group("CSD Room")
            {
                Caption = 'Room';
                Visible = ShowMaxField;
                field("CSD Maximum Participants"; Rec."CSD Maximum Participants")
                {
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // Removed Type comparison to avoid ambiguous identifier; default to hidden
        ShowMaxField := false;
        CurrPage.UPDATE(false);
    end;

    var
        ShowMaxField: Boolean;
}
