codeunit 60000 "Interest Mgt"
{
    local procedure CalcInterest(Amount: Decimal; CalcDuration: Integer; InterestRate: Decimal) AmountN: Decimal
    var
        I: Integer;
    begin
        AmountN := Amount;

        GetInterestCalcSetup();

        for I := 1 to CalcDuration do
            AmountN := AmountN + Round(AmountN * InterestRate / 100);
    end;

    local procedure CalcInterestArray(Amount: Decimal; DurationYears: array[1] of Integer; InterestPercent: array[1] of Decimal) AmountN: Decimal
    var
        I: Integer;
        Error001: Label 'Unequal count of parameters!';
    begin
        if ArrayLen(DurationYears) <> ArrayLen(InterestPercent) then
            Error(Error001);

        AmountN := Amount;

        FOR I := 1 TO Step DO
            AmountN := CalcInterest(AmountN, DurationYears[I], InterestPercent[I]);
    end;

    local procedure ClearSteps()
    begin
        Step := 0;
    end;

    local procedure GetInterestCalcSetup()
    begin
        if not IntCalSetupRead then begin
            IntCalcSetup.Get();
            IntCalSetupRead := true;
        end;
    end;

    procedure CalcSteps(Amount: Decimal) AmountN: Decimal
    begin
        AmountN := CalcInterestArray(Amount, DurationYears, InterestPercent);
        ClearSteps();
    end;

    procedure AddStep(DurationYears2: Integer; InterestPercent2: Decimal)
    begin
        Step += 1;
        DurationYears[Step] := DurationYears2;
        InterestPercent[Step] := InterestPercent2;
    end;

    procedure CalcScheme(IntCalcSchemeNo: Code[20]; Amount: Decimal; PostingDate: Date) AmountN: Decimal
    var
        InterestCalcScheme: Record "Interest Calc. Scheme";
        InterestCalcSchemeLine: Record "Interest Calc. Scheme Line";
    begin
        AmountN := Amount;

        if (IntCalcSchemeNo = '') or (Amount = 0.0) or (PostingDate = 0D) then
            exit;

        InterestCalcScheme.Get(IntCalcSchemeNo);
        InterestCalcScheme.TestBlocked();
        InterestCalcScheme.TestAmount(Amount);
        InterestCalcScheme.TestDate(PostingDate);

        // SetCurrentKey für richtige Sortierung, muss aber nicht verwendet werden ;-)
        InterestCalcSchemeLine.SetCurrentKey("Interest Calc. Scheme Code", "Line No.");
        InterestCalcSchemeLine.SetRange("Interest Calc. Scheme Code", InterestCalcScheme.Code);

        // Lösung über State Machine (Zustandsautomat)
        if InterestCalcSchemeLine.FindSet() then
            repeat
                AddStep(InterestCalcSchemeLine."Duration Years", InterestCalcSchemeLine."Interest Percent");
            until InterestCalcSchemeLine.Next() = 0;

        AmountN := CalcSteps(Amount);

        // Auch möglich:
        // if InterestCalcSchemeLine.FindSet() then
        //     repeat
        //         AmountN := CalcInterest(AmountN, InterestCalcSchemeLine."Duration Years", InterestCalcSchemeLine."Interest Percent");
        //     until InterestCalcSchemeLine.Next() = 0;
    end;

    /* UNUSED FUNCTION */
    local procedure CalcInterestWithArray(Amount: Decimal; DurationYears: array[2] of Integer; InterestPercent: array[2] of Decimal) AmountN: Decimal
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

    var
        IntCalcSetup: Record "Interest Calc. Setup";
        Step: Integer;
        DurationYears: array[100] of Integer;
        InterestPercent: array[100] of Decimal;
        IntCalSetupRead: Boolean;
}