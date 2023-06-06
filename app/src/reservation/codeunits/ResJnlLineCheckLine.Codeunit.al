codeunit 50101 "Res. Jnl. Line - Check Line"
{

    procedure RunOnValidateResJnlRecord(fromTable: Record "Reservation Jnl Line")
    var
        PostValidationEmptyErr: Label '%1 Can not be empty from No. %2';
        PostValidationValueErr: Label '%1 is not valid because it %2 from No. %3', Comment = '%1 status field value';

    begin
        if fromTable.IsEmpty() then
            Error(PostValidationEmptyErr, 'Journal Table line', '');

        if fromTable."Golf Course No." = '' then
            Error(PostValidationEmptyErr, 'Golf Course', fromTable."No.");

        if fromTable."No. of Actual Players" <= 0 then
            Error(PostValidationValueErr, 'Number of  players', 'must be greater than 0', fromTable."No.");

        if fromTable."Date of Play" = 0D then
            Error(PostValidationEmptyErr, 'Date of Play', fromTable."No.");

        if (fromTable.Type = Enum::"Reservation Type"::Member) and (fromTable."Club Member No." = '') then
            Error(PostValidationEmptyErr, 'Club Member Number', fromTable."No.");

        if fromTable."Total Fee" < 0 then
            Error(PostValidationValueErr, 'Total Fee', 'value must be a positive number', fromTable."No.");

    end;

}