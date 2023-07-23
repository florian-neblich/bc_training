table 60000 "Interest Calc. Scheme"
{
    DataClassification = CustomerContent;
    Caption = 'Interest Calc. Scheme';

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(11; "Search Description"; Code[50])
        {
            Caption = 'Search Description';
        }
        field(12; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(13; "Min. Amount"; Decimal)
        {
            Caption = 'Min. Amount';
        }
        field(14; "Max. Amount"; Decimal)
        {
            Caption = 'Max. Amount';
        }
        field(15; "Valid From"; Date)
        {
            Caption = 'Valid From';
        }
        field(16; "Valid To"; Date)
        {
            Caption = 'Valid To';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Description, "Min. Amount", "Max. Amount")
        { }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}