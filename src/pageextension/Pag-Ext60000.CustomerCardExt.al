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
                    TotalCapital: Decimal;
                    CalcDuration: Integer;
                    I: Integer;
                    Text60000: Label 'Total amount: %2 MW';
                begin
                    TotalCapital := Rec."Credit Limit (LCY)";
                    CalcDuration := 10;

                    for I := 1 TO CalcDuration do begin
                        if I <= 5 then
                            TotalCapital := Round(TotalCapital * 1.03)
                        else
                            TotalCapital := Round(TotalCapital * 1.04);
                    end;
                end;
            }
        }
    }
}