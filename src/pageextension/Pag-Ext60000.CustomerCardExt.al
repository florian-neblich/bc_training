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
                    Text60000: Label 'Total amount: %2 MW';
                begin
                    GenLedgerSetup.Get();

                    TotalCapital := Rec."Credit Limit (LCY)";

                    DurationYears[1] := 5;
                    DurationYears[2] := 5;

                    InterestPercent[1] := 3.0;
                    InterestPercent[2] := 4.0;

                    TotalCapital := InterestMgt.CalcInterestWithArray(TotalCapital, DurationYears, InterestPercent);

                    Message(Text60000, Format(Round(TotalCapital, GenLedgerSetup."Amount Rounding Precision")));
                end;
            }
        }
    }
}