codeunit 50103 "Res. Jnl. Line - Post Batch"
{
    var
        ResJnlLineCheckLine: Codeunit "Res. Jnl. Line - Check Line";
        ResJnlLinePostLine: Codeunit "Res. Jnl. Line - Post Line";

    procedure RunOnPostBatchResJnlToLedger(fromTable: Record "Reservation Jnl Line"; toTable: Record "Reservation Ledger Entry")
    begin

        repeat
            fromTable.FindSet();
            ResJnlLineCheckLine.RunOnValidateResJnlRecord(fromTable);
            ResJnlLinePostLine.RunOnPostResJnlLineRecordToLedger(fromTable, toTable);
        until fromTable.Next() = 0;
        fromTable.DeleteAll();
    end;

}