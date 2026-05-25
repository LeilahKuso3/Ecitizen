page 50107 "CSD Seminar Comment List"
{
    Caption = 'Seminar Comment List';
    PageType = List;
    SourceTable = "CSD Seminar Comment Line";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DateField; Rec.Date)
                {
                }
                field(CodeField; Rec.Code)
                {
                    Visible = false;
                }
                field(CommentField; Rec.Comment)
                {
                }
            }
        }
    }
}
