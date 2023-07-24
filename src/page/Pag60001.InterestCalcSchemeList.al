page 60001 "Interest Calc. Scheme List"
{
    Caption = 'Interest Calc. Scheme List';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Interest Calc. Scheme";
    CardPageId = "Interest Calc. Scheme Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Min. Amount"; Rec."Min. Amount")
                {
                    ApplicationArea = All;
                }
                field("Max. Amount"; Rec."Max. Amount")
                {
                    ApplicationArea = All;
                }
                field("Valid From"; Rec."Valid From")
                {
                    ApplicationArea = All;
                }
                field("Valid To"; Rec."Valid To")
                {
                    ApplicationArea = All;
                }
                field("Total Duration Years"; Rec."Total Duration Years")
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            group("Interest Calc. Scheme")
            {
                Caption = 'Interest Calc. Scheme';

                action(InterestCalcSchemeLine)
                {
                    ApplicationArea = All;
                    Image = EditList;
                    RunObject = page "Interest Calc. Scheme Lines";
                    RunPageLink = "Interest Calc. Scheme Code" = field(Code);
                }
                action(Comment)
                {
                    Caption = 'Comments';
                    ApplicationArea = All;
                    Image = ViewComments;
                    RunObject = page "Comment Sheet";
                    RunPageLink = "Table Name" = const("Interest Calc. Scheme"), "No." = field(Code);
                }
            }
        }
    }
}