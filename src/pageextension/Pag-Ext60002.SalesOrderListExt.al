pageextension 60002 "Sales Order List Ext." extends "Sales Order List"
{
    layout
    {
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

                trigger OnAction()
                var
                    InterstCalculator: Page "Interest Calculator";
                begin
                    Clear(InterstCalculator);
                    if Rec."Interest Calc. Scheme No." <> '' then begin
                        InterstCalculator.SetInterestCalcSchemeNo(Rec."Interest Calc. Scheme No.");
                        Rec.CalcFields("Amount Including VAT");
                        InterstCalculator.SetInterestAmount(Rec."Amount Including VAT");
                        InterstCalculator.SetInterestPostingDate(Rec."Order Date");
                    end;

                    InterstCalculator.Run();
                end;
            }
        }
    }
}