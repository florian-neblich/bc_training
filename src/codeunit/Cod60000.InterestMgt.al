codeunit 60000 "Interest Mgt"
{
    procedure CalcInterest(Amount: Decimal; CalcDuration: Integer; InterestRate: Decimal) AmountN: Decimal
    var
        I: Integer;
    begin
        AmountN := Amount;

        for I := 1 to CalcDuration do
            AmountN := AmountN + Round(AmountN * InterestRate / 100);
    end;
}