page 60007 "Interest Calc. FactBox"
{
    Caption = 'Interest Calc. Details';
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = "Interest Calc. Scheme";

    layout
    {
        area(Content)
        {
            group(InterstCalcDetails)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Interest Calc. Scheme Card";
                    LookupPageID = "Interest Calc. Scheme Card";
                }
                field(Description; Rec.Description)
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
    }
}