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
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}