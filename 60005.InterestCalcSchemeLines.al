page 60005 "Interest Calc. Scheme Lines"
{
    Caption = 'Interest Calc. Scheme Lines';
    PageType = List;
    SourceTable = "Interest Calc. Scheme Line";
    AutoSplitKey = true;
    DataCaptionFields = "Interest Calc. Scheme Code";

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