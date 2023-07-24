page 60003 "Interest Calc. Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Interest Calc. Setup";
    Caption = 'Interest Calc. Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Interest Rounding Precision"; Rec."Interest Rounding Precision")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();

        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}