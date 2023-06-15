codeunit 50103 "Res. Jnl. Line - Post Batch"
{
    var
        ResJnlLineCheckLine: Codeunit "Res. Jnl. Line - Check Line";
        ResJnlLinePostLine: Codeunit "Res. Jnl. Line - Post Line";

    procedure RunOnPostBatchResJnlToLedger(ReservationJnlLine: Record "Reservation Jnl Line"; ReservationLedgerEntry: Record "Reservation Ledger Entry")
    begin

        repeat
            ReservationJnlLine.FindSet();
            ResJnlLineCheckLine.RunOnValidateResJnlRecord(ReservationJnlLine);
            ResJnlLinePostLine.RunOnPostResJnlLineRecordToLedger(ReservationJnlLine, ReservationLedgerEntry);
        until ReservationJnlLine.Next() = 0;
        ReservationJnlLine.DeleteAll();
    end;

}