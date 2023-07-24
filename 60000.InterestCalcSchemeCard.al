page 60000 "Interest Calc. Scheme Card"
{
    PageType = Document;
    UsageCategory = Documents;
    SourceTable = "Interest Calc. Scheme";
    DataCaptionFields = Code, Description;
    Caption = 'Interest Calc. Scheme Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        if Rec.Code <> xRec.Code then
                            CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
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
            part("Int.Calc. Scheme Lines Subform"; "Int.Calc. Scheme Lines Subform")
            {
                Caption = 'Lines';
                SubPageLink = "Interest Calc. Scheme Code" = field(Code);
            }
            group(Invoice)
            {
                Caption = 'Invoice';

                field("Min. Amount"; Rec."Min. Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Max. Amount"; Rec."Max. Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
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
            }
        }
    }

    var
        myInt: Integer;
}