table 60001 "Interest Calc. Scheme Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Interest Calc. Scheme Code"; Code[20])
        {
            Caption = 'Interest Calc. Scheme Code';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(10; "Duration Years"; Integer)
        {
            Caption = 'Duration Years';
        }
        field(11; "Interest Percent"; Decimal)
        {
            Caption = 'Interest Percent';
        }
    }

    keys
    {
        key(PK; "Interest Calc. Scheme Code", "Line No.")
        {
            Clustered = true;
        }
    }
}