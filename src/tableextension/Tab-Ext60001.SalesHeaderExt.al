tableextension 60001 "Sales Header Ext." extends "Sales Header"
{
    fields
    {
        field(60000; "Interest Calc. Scheme No."; Code[20])
        {
            Caption = 'Interese Calc. Scheme Code';
            TableRelation = "Interest Calc. Scheme";
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

    var
        InterestCalcScheme: Record "Interest Calc. Scheme";
        Text003: Label 'The Date %1 ist not within the range of allowed dates.';
}