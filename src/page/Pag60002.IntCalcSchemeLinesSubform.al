page 60002 "Int.Calc. Scheme Lines Subform"
{
    PageType = ListPart;
    SourceTable = "Interest Calc. Scheme Line";
    AutoSplitKey = true;
    DelayedInsert = true;
    ShowFilter = false;
    Caption = 'Interest Calc. Scheme Line';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Duration Years"; Rec."Duration Years")
                {
                    ApplicationArea = All;
                }
                field("Interest Percent"; Rec."Interest Percent")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}