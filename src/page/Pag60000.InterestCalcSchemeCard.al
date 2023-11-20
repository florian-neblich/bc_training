page 60000 "Interest Calc. Scheme Card"
{
    PageType = Document;
    UsageCategory = Documents;
    SourceTable = "Interest Calc. Scheme";
    DataCaptionFields = "No.", Description;
    Caption = 'Interest Calc. Scheme Card';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Valid From"; Rec."Valid From")
                {
                    ApplicationArea = All;
                    ShowMandatory = ShowMandatory;
                }
                field("Valid To";
                Rec."Valid To")
                {
                    ApplicationArea = All;
                    ShowMandatory = ShowMandatory;
                }
                field("Total Duration Years"; Rec."Total Duration Years")
                {
                    ApplicationArea = All;
                }
            }
            part("Int.Calc. Scheme Lines Subform"; "Int.Calc. Scheme Lines Subform")
            {
                Caption = 'Lines';
                SubPageLink = "Interest Calc. Scheme Code" = field("No.");
                UpdatePropagation = Both;
            }
            group(Invoice)
            {
                Caption = 'Invoice';

                field("Min. Amount"; Rec."Min. Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Max. Amount"; Rec."Max. Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Interest Calc. Scheme")
            {
                Caption = 'Interest Calc. Scheme';

                action(InterestCalcSchemeLine)
                {
                    ApplicationArea = All;
                    Image = EditList;
                    RunObject = page "Interest Calc. Scheme Lines";
                    RunPageLink = "Interest Calc. Scheme Code" = field("No.");
                }
                action(Comment)
                {
                    Caption = 'Comments';
                    ApplicationArea = All;
                    Image = ViewComments;
                    RunObject = page "Comment Sheet";
                    RunPageLink = "Table Name" = const("Interest Calc. Scheme"), "No." = field("No.");
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CheckMandatoryFields();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CheckMandatoryFields();
    end;

    local procedure CheckMandatoryFields()
    var
        InterestCalcSetup: Record "Interest Calc. Setup";
    begin
        InterestCalcSetup.Get();
        ShowMandatory := InterestCalcSetup.GetRequireValidity();
    end;

    var
        ShowMandatory: Boolean;
}