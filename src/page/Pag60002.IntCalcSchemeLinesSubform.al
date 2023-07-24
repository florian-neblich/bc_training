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

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Interest Percent"; Rec."Interest Percent")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.Update();
    end;
}