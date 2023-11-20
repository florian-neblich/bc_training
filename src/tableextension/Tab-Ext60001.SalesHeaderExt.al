tableextension 60001 "Sales Header Ext." extends "Sales Header"
{
    fields
    {
        field(60000; "Interest Calc. Scheme No."; Code[20])
        {
            Caption = 'Interese Calc. Scheme Code';
            TableRelation = "Interest Calc. Scheme";

            trigger OnValidate()
            begin
                TestStatusOpen();

                if Rec."Interest Calc. Scheme No." <> xRec."Interest Calc. Scheme No." then begin
                    if not TestInterestCalculation(false) then
                        InterestCalcScheme.Init();

                    Rec."Interest Calc. Description" := InterestCalcScheme.Description;
                    Rec."Valid From" := InterestCalcScheme."Valid From";
                    Rec."Valid To" := InterestCalcScheme."Valid To";
                end;

                // if InterestCalcScheme.Get(Rec."Interest Calc. Scheme No.") then begin
                //     Rec."Interest Calc. Description" := InterestCalcScheme.Description;
                //     Rec."Valid From" := InterestCalcScheme."Valid From";
                //     Rec."Valid To" := InterestCalcScheme."Valid To";
                // end else begin
                //     Rec."Interest Calc. Description" := '';
                //     Rec."Valid From" := 0D;
                //     Rec."Valid To" := 0D;
                // end;
            end;
        }
        field(60001; "Interest Calc. Description"; Text[50])
        {
            Caption = 'Description';
            Editable = false;

            trigger OnValidate()
            begin
                TestStatusOpen();
                TestField("Interest Calc. Scheme No.");
            end;
        }
        field(60002; "Valid From"; Date)
        {
            Caption = 'Valid From';
            Editable = false;

            trigger OnValidate()
            begin
                TestStatusOpen();

                if (Rec."Valid From" <> 0D) and (Rec."Valid To" < 0D) and (Rec."Valid From" > Rec."Valid To") then
                    FieldError("Valid To", StrSubstNo(Text003, FieldCaption(Rec."Valid From")));
            end;
        }
        field(60003; "Valid To"; Date)
        {
            Caption = 'Valid to';
            Editable = false;

            trigger OnValidate()
            begin
                TestStatusOpen();

                if (Rec."Valid From" <> 0D) and (Rec."Valid To" < 0D) and (Rec."Valid From" > "Valid To") then
                    FieldError("Valid To", StrSubstNo(Text003, FieldCaption(Rec."Valid To")));
            end;
        }
    }

    procedure TestInterestCalculation(TestAmount: Boolean): Boolean
    begin
        if Rec."Interest Calc. Scheme No." = '' then
            exit(false);

        if InterestCalcScheme."No." <> Rec."Interest Calc. Scheme No." then
            InterestCalcScheme.Get(Rec."Interest Calc. Scheme No.");

        InterestCalcScheme.TestBlocked();
        InterestCalcScheme.TestDate("Order Date");

        if TestAmount then
            InterestCalcScheme.TestAmount("Amount Including VAT");

        exit(true);
    end;

    var
        InterestCalcScheme: Record "Interest Calc. Scheme";
        Text003: Label 'The Date %1 ist not within the range of allowed dates.';
}