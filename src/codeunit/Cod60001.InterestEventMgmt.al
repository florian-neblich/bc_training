codeunit 60001 "Interest Event Mgmt."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', true, true)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; var SkipCheckReleaseRestrictions: Boolean)
    var
        Error001: Label 'Interest scheme could not be validated!';
    begin
        if not (SalesHeader.TestInterestCalculation(true)) then
            Error(StrSubstNo('%1\\%2', Error001, GetLastErrorText()));
    end;
}