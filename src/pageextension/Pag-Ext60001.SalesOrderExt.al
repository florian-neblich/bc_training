pageextension 60001 "Sales Order Ext." extends "Sales Order"
{
    layout
    {
        addafter(Control1900201301)
        {
            group(InterestCalculation)
            {
                Caption = 'Interest Calculation';

                field("Interest Calc. Scheme No."; Rec."Interest Calc. Scheme No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        InterestCalcScheme: Record "Interest Calc. Scheme";
                        InterestCalcSchemeList: Page "Interest Calc. Scheme List";
                    begin
                        Rec.TestStatusOpen();

                        InterestCalcScheme.FilterGroup(2);

                        InterestCalcScheme.SetRange(Blocked, false);
                        InterestCalcScheme.SetCurrentKey("Max. Amount");
                        InterestCalcScheme.Ascending(true);

                        InterestCalcSchemeList.SetTableView(InterestCalcScheme);
                        InterestCalcSchemeList.SetRecord(InterestCalcScheme);
                        InterestCalcSchemeList.Editable(false);
                        InterestCalcSchemeList.LookupMode(true);

                        if InterestCalcSchemeList.RunModal = Action::LookupOK then begin
                            InterestCalcSchemeList.GetRecord(InterestCalcScheme);
                            Rec.Validate("Interest Calc. Scheme No.", InterestCalcScheme."No.");
                        end;

                        InterestCalcSchemeList.LookupMode(false);
                        InterestCalcSchemeList.Editable(true);
                    end;
                }
                field("Interest Calc. Description"; Rec."Interest Calc. Description")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Valid From"; Rec."Valid From")
                {
                    ApplicationArea = All;
                    ShowMandatory = RequireValidityMandatory;
                }
                field("Valid To"; Rec."Valid To")
                {
                    ApplicationArea = All;
                    ShowMandatory = RequireValidityMandatory;
                }
            }
        }

        addafter(Control1900316107)
        {
            part(InterestCalcFactBox; "Interest Calc. FactBox")
            {
                ApplicationArea = All;
                Caption = 'Interest Calc. Details';
                SubPageLink = "No." = field("Interest Calc. Scheme No.");
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action(OpenInterestCalculator)
            {
                Caption = 'Calc. Total Capital';
                ApplicationArea = All;
                Image = CalculateDiscount;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = CalculatorForOrderEnabled;

                trigger OnAction()
                var
                    InterstCalculator: Page "Interest Calculator";
                begin
                    InterstCalculator.SetInterestCalcSchemeNo(Rec."Interest Calc. Scheme No.");
                    Rec.CalcFields("Amount Including VAT");
                    InterstCalculator.SetInterestAmount(Rec."Amount Including VAT");
                    InterstCalculator.SetInterestPostingDate(Rec."Order Date");

                    InterstCalculator.Run();
                end;
            }
        }
    }

    local procedure SetRequireValidityMandatoryCondition()
    var
        InterestCalcSetup: Record "Interest Calc. Setup";
    begin
        InterestCalcSetup.Get();

        RequireValidityMandatory := InterestCalcSetup.GetRequireValidity();
    end;

    local procedure SetCalculatorForOrderEnabled()
    begin
        CalculatorForOrderEnabled := false;
        if Rec."Interest Calc. Scheme No." <> '' then
            CalculatorForOrderEnabled := true;
    end;

    trigger OnOpenPage()
    begin
        SetRequireValidityMandatoryCondition();
        SetCalculatorForOrderEnabled();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetRequireValidityMandatoryCondition();
        SetCalculatorForOrderEnabled();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        SetCalculatorForOrderEnabled();
    end;

    var
        RequireValidityMandatory: Boolean;
        CalculatorForOrderEnabled: Boolean;
}