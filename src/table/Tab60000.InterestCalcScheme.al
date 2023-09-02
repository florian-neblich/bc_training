table 60000 "Interest Calc. Scheme"
{
    DataClassification = CustomerContent;
    Caption = 'Interest Calc. Scheme';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if Rec."No." <> xRec."No." then begin
                    IntCalcScheme.Get();
                    NoSeriesMgt.TestManual(IntCalcScheme."No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := Description;
            end;
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

            trigger OnValidate()
            begin
                if ("Min. Amount" > 0.0) and ("Max. Amount" <> 0.0) and ("Min. Amount" > "Max. Amount") then // Lt. Standard auch nur "0" möglich
                    FieldError("Min. Amount", StrSubstNo(Text000, FieldCaption("Max. Amount")));
            end;
        }
        field(14; "Max. Amount"; Decimal)
        {
            Caption = 'Max. Amount';

            trigger OnValidate()
            begin
                if ("Min. Amount" > 0.0) and ("Max. Amount" <> 0.0) and ("Min. Amount" < "Max. Amount") then // Lt. Standard auch nur "0" möglich
                    FieldError("Max. Amount", StrSubstNo(Text000, FieldCaption("Min. Amount")));
            end;
        }
        field(15; "Valid From"; Date)
        {
            Caption = 'Valid From';

            trigger OnValidate()
            begin
                if ("Valid From" <> 0D) and ("Valid To" <> 0D) and ("Valid From" > "Valid To") then
                    FieldError("Valid From", StrSubstNo(Text000, FieldCaption("Valid To")));
            end;
        }
        field(16; "Valid To"; Date)
        {
            Caption = 'Valid To';

            trigger OnValidate()
            begin
                if ("Valid From" <> 0D) and ("Valid To" <> 0D) and ("Valid From" > "Valid To") then
                    FieldError("Valid To", StrSubstNo(Text001, FieldCaption("Valid From")));
            end;
        }
        field(17; "Total Duration Years"; Decimal)
        {
            Caption = 'Total Duration Years';
            FieldClass = FlowField;
            CalcFormula = sum("Interest Calc. Scheme Line"."Duration Years" where("Interest Calc. Scheme Code" = field("No.")));
        }
        field(20; "Comment"; Boolean)
        {
            Caption = 'Comment';
            FieldClass = FlowField;
            CalcFormula = exist("Comment Line" where("Table Name" = const("Interest Calc. Scheme"), "No." = field("No.")));
            Editable = false;
        }
        field(30; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, "Min. Amount", "Max. Amount")
        { }
    }

    trigger OnDelete()
    var
        InterestCalcSchemeLine: Record "Interest Calc. Scheme Line";
    begin
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::"Interest Calc. Scheme");
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll();

        InterestCalcSchemeLine.SetRange("Interest Calc. Scheme Code", Rec."No.");
        InterestCalcSchemeLine.DeleteAll();
    end;

    trigger OnInsert()
    begin
        if Rec."No." = '' then begin
            InterestCalcSetup.Get();
            InterestCalcSetup.TestField("Int. Calc. Scheme Nos.");
            NoSeriesMgt.InitSeries(InterestCalcSetup."Int. Calc. Scheme Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    procedure TestBlocked()
    begin
        // if Blocked then
        //     Error(50001);
        // Besser:
        TestField(Blocked, false);
    end;

    procedure TestAmount(Amount: Decimal)
    begin
        if (("Min. Amount" > 0.0) and (Amount < "Min. Amount")) or (("Max. Amount" > 0.0) and (Amount > "Max. Amount")) then
            // Lt. Standard auch nur "0" möglich
            Error(Text002, "Min. Amount", "Max. Amount");
    end;

    procedure TestDate(PostingDate: Date)
    begin
        if PostingDate = 0D then
            PostingDate := WorkDate();

        if (("Valid From" <> 0D) and (PostingDate < "Valid From")) or (("Valid To" <> 0D) and (PostingDate > "Valid To")) then
            Error(Text003, "Valid From", "Valid To");
    end;

    procedure AssistEdit(OldCalcScheme: Record "Interest Calc. Scheme"): Boolean;
    VAR
        IntCalcScheme: Record "Interest Calc. Scheme";
    begin
        IntCalcScheme := Rec;
        InterestCalcSetup.Get();
        InterestCalcSetup.TestField("Int. Calc. Scheme Nos.");
        if NoSeriesMgt.SelectSeries(InterestCalcSetup."Int. Calc. Scheme Nos.", OldCalcScheme."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            Rec := IntCalcScheme;
            exit(true);
        end;
    end;

    var
        CommentLine: Record "Comment Line";
        IntCalcScheme: Record "Interest Calc. Scheme";
        InterestCalcSetup: Record "Interest Calc. Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text000: Label 'must not be greater than %1!';
        Text001: Label 'must not be less than %1!';
        Text002: Label 'The Amound is not within the range of allowed amounts %1..%2';
        Text003: Label 'The Date ist not within the range of allowed dates %1..%2.';

}