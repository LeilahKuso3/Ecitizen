page 50106 "CSD Seminar Comment Sheet"
{
    Caption = 'Seminar Comment Sheet';
    PageType = List;
    SourceTable = "CSD Seminar Comment Line";

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
