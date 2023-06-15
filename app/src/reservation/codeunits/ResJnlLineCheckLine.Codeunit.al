codeunit 50101 "Res. Jnl. Line - Check Line"
{

    procedure RunOnValidateResJnlRecord(ReservationJnlLine: Record "Reservation Jnl Line")
    var
        PostValidationEmptyErr: Label '%1 Can not be empty from No. %2', Comment = '%1 status field value, %2 row identifier';
        PostValidationValueErr: Label '%1 is not valid because it %2 from No. %3', Comment = '%1 status field value,%2  error reason,%3 row identifier';

    begin
        if ReservationJnlLine.IsEmpty() then
            Error(PostValidationEmptyErr, 'Journal Table line', '');

        if ReservationJnlLine."Golf Course No." = '' then
            Error(PostValidationEmptyErr, 'Golf Course', ReservationJnlLine."No.");

        if ReservationJnlLine."No. of Actual Players" <= 0 then
            Error(PostValidationValueErr, 'Number of  players', 'must be greater than 0', ReservationJnlLine."No.");

        if ReservationJnlLine."Date of Play" = 0D then
            Error(PostValidationEmptyErr, 'Date of Play', ReservationJnlLine."No.");

        if (ReservationJnlLine.Type = Enum::"Reservation Type"::Member) and (ReservationJnlLine."Club Member No." = '') then
            Error(PostValidationEmptyErr, 'Club Member Number', ReservationJnlLine."No.");

        if ReservationJnlLine."Total Fee" < 0 then
            Error(PostValidationValueErr, 'Total Fee', 'value must be a positive number', ReservationJnlLine."No.");

    end;

}