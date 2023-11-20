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
    }

    local procedure SetRequireValidityMandatoryCondition()
    var
        InterestCalcSetup: Record "Interest Calc. Setup";
    begin
        InterestCalcSetup.Get();

        RequireValidityMandatory := InterestCalcSetup.GetRequireValidity();
    end;

    trigger OnOpenPage()
    begin
        SetRequireValidityMandatoryCondition();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetRequireValidityMandatoryCondition();
    end;

    var
        RequireValidityMandatory: Boolean;
}