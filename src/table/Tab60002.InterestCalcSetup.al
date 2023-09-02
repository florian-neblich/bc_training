table 60002 "Interest Calc. Setup"
{
    Caption = 'Interest Calc. Setup';
    LookupPageId = 60003;
    DrillDownPageId = 60003;

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
        }
        field(2; "Interest Rounding Precision"; Decimal)
        {
            Caption = 'Interest Round. Precision';
            InitValue = 0.01;
        }
        field(10; "Int. Calc. Scheme Nos."; Code[20])
        {
            Caption = 'Sales VAT Advance Notif. Nos.';
            TableRelation = "No. Series".Code;
        }
        field(15; "Require Validity"; Boolean)
        {
            Caption = 'Validity Required';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    procedure GetRequireValidity() IsRequired: Boolean
    begin
        IsRequired := Rec."Require Validity";
    end;
}