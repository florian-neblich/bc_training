page 60006 "Interest Calculator"
{
    Caption = 'Interest Calculator';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("Calculation Parameter")
            {
                Caption = 'Calculation Parameter';

                grid(GridCol)
                {
                    GridLayout = Columns;

                    grid(GridRow)
                    {
                        GridLayout = Rows;

                        field(IntCalcSchemeNo; IntCalcSchemeNo)
                        {
                            Caption = 'Interest Calc. Scheme No.:';
                            ApplicationArea = All;
                            TableRelation = "Interest Calc. Scheme";

                            trigger OnValidate()
                            begin
                                CalcAmount(IntCalcSchemeNo, Amount, PostingDate);
                                ShowLines := false;
                                if IntCalcSchemeNo <> '' then begin
                                    SetCurrCalcSchemeFilter();
                                    ShowLines := true;
                                    CurrPage.Update();
                                end;
                            end;
                        }

                        field(Amount; Amount)
                        {
                            Caption = 'Amount:';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                CalcAmount(IntCalcSchemeNo, Amount, PostingDate);
                            end;
                        }

                        field(PostingDate; PostingDate)
                        {
                            Caption = 'Posting Date:';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                CalcAmount(IntCalcSchemeNo, Amount, PostingDate);
                            end;
                        }
                    }
                }
            }
            group(Result)
            {
                Caption = 'Result';

                grid(GridCol2)
                {
                    grid(GridRow2)
                    {
                        field(AmountN; AmountN)
                        {
                            Caption = 'Interest Amount:';
                            ApplicationArea = All;
                            Enabled = false;
                            Editable = false;
                        }
                    }
                }
            }
            part(IntCalcSchemeLinesSub; "Int.Calc. Scheme Lines Subform")
            {
                Caption = 'Interest Calc. Scheme Lines';
                ApplicationArea = All;
                Visible = ShowLines;
            }
        }
    }

    local procedure CalcAmount(piIntCalcSchemeNo: Code[20]; piAmount: Decimal; piPostingDate: Date)
    begin
        AmountN := InterestMgt.CalcScheme(piIntCalcSchemeNo, piAmount, piPostingDate);
    end;

    local procedure SetCurrCalcSchemeFilter()
    begin
        IntCalcSchemeLine.SetRange("Interest Calc. Scheme Code", IntCalcSchemeNo);
        if IntCalcSchemeLine.FindSet() then
            IntCalcSchemeLinesSub.SetTableView(IntCalcSchemeLine);
    end;

    var
        IntCalcSchemeLine: Record "Interest Calc. Scheme Line";
        InterestMgt: Codeunit "Interest Mgt";
        "IntCalcSchemeLinesSub": Page "Int.Calc. Scheme Lines Subform";
        IntCalcSchemeNo: Code[20];
        Amount: Decimal;
        AmountN: Decimal;
        PostingDate: Date;
        ShowLines: Boolean;
}