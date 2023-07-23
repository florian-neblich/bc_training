codeunit 60000 "Interest Mgt"
{
    local procedure CalcInterest(Amount: Decimal; CalcDuration: Integer; InterestRate: Decimal) AmountN: Decimal
    var
        I: Integer;
    begin
        AmountN := Amount;

        for I := 1 to CalcDuration do
            AmountN := AmountN + Round(AmountN * InterestRate / 100);
    end;

    procedure CalcInterestWithArray(Amount: Decimal; DurationYears: array[2] of Integer; InterestPercent: array[2] of Decimal) AmountN: Decimal
    var
        I: Integer;
        Error001: Label 'Unequal count of parameters!';
    begin
        if ArrayLen(DurationYears) <> ArrayLen(InterestPercent) then
            Error(Error001);

        AmountN := Amount;

        for I := 1 to ArrayLen(DurationYears) do
            AmountN := CalcInterest(AmountN, DurationYears[I], InterestPercent[I]);
    end;
}