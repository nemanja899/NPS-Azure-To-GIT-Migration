codeunit 50102 "Res. Jnl. Line - Post Line"
{
    procedure RunOnPostResJnlLineRecordToLedger(ReservationJnlLine: Record "Reservation Jnl Line"; ReservationLedgerEntry: Record "Reservation Ledger Entry")
    begin
        ReservationLedgerEntry.Init();
        ReservationLedgerEntry."Golf Course No." := ReservationJnlLine."Golf Course No.";
        ReservationLedgerEntry."Reservation Type" := ReservationJnlLine.Type;
        ReservationLedgerEntry."Club Member No." := ReservationJnlLine."Club Member No.";
        ReservationLedgerEntry."Date of Play" := ReservationJnlLine."Date of Play";
        ReservationLedgerEntry."No. of Players" := ReservationJnlLine."No. of Actual Players";
        ReservationLedgerEntry."Tee TIme" := ReservationJnlLine."Tee TIme";
        ReservationLedgerEntry."Total Fee" := ReservationJnlLine."Total Fee";
        ReservationLedgerEntry.Insert(true);

    end;

}