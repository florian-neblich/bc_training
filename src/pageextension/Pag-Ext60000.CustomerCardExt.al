pageextension 60000 CustomerCardExt extends "Customer Card"
{
    actions
    {
        addlast(processing)
        {
            action(CalculateTotalCapital)
            {
                Caption = 'Calc. Total Capital';
                ApplicationArea = All;
                Image = CalculateDiscount;

                trigger OnAction()
                var
                    GenLedgerSetup: Record "General Ledger Setup";
                    InterestMgt: Codeunit "Interest Mgt";
                    TotalCapital: Decimal;
                    DurationYears: array[2] of Integer;
                    InterestPercent: array[2] of Decimal;
                    Text60000: Label 'Total amount: %1 MW';
                begin
                    GenLedgerSetup.Get();

                    TotalCapital := Rec."Credit Limit (LCY)";

                    InterestMgt.AddStep(5, 3.0);
                    InterestMgt.AddStep(5, 4.0);

                    TotalCapital := InterestMgt.CalcSteps(TotalCapital);

                    Message(Text60000, Format(Round(TotalCapital, GenLedgerSetup."Amount Rounding Precision")));
                end;
            }
        }
    }
}