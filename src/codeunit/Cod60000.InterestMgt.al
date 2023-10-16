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


    // THIS FUNCTION WE DO NOT USE AGAIN!!!!!!!!
    procedure CalcInterestWithArray(Amount: Decimal; DurationYears: array[2] of Integer; InterestPercent: array[2] of Decimal) AmountN: Decimal
    var
        I: Integer;
    begin
        AmountN := Amount;

        for I := 1 to ArrayLen(DurationYears) do
            AmountN := CalcInterest(AmountN, DurationYears[I], InterestPercent[I]);
    end;

    local procedure ClearSteps()
    begin
        Step := 0;
    end;

    procedure AddStep(DurationYears2: Integer; InterestPercent2: Decimal)
    begin
        Step += 1;
        DurationYears[Step] := DurationYears2;
        InterestPercent[Step] := InterestPercent2;
    end;

    procedure CalcSteps(Amount: Decimal) AmountN: Decimal
    begin
        AmountN := Amount;
        AmountN := CalcInterestArray(AmountN, DurationYears, InterestPercent);
        ClearSteps();
    end;

    procedure CalcInterestArray(Amount: Decimal; DurationYears: array[1] of Integer; InterestPercent: array[1] of Decimal) AmountN: Decimal
    var
        I: Integer;
    begin
        AmountN := Amount;

        for I := 1 to Step do
            AmountN := CalcInterest(AmountN, DurationYears[I], InterestPercent[I]);
    end;

    var
        Step: Integer;
        DurationYears: array[100] of Integer;
        InterestPercent: array[100] of Decimal;
}