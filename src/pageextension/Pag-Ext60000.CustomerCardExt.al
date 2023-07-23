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
                    TotalCapital: Decimal;
                    CalcDuration: Integer;
                    I: Integer;
                    Text60000: Label 'Total amount: %2 MW';
                begin
                    GenLedgerSetup.Get();

                    TotalCapital := Rec."Credit Limit (LCY)";
                    CalcDuration := 10;

                    for I := 1 TO CalcDuration do begin
                        if I <= 5 then
                            TotalCapital := Round(TotalCapital * 1.03)
                        else
                            TotalCapital := Round(TotalCapital * 1.04);
                    end;

                    Message(Text60000, Format(Round(TotalCapital, GenLedgerSetup."Amount Rounding Precision")));
                end;
            }
        }
    }
}