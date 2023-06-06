codeunit 50103 "Res. Jnl. Line - Post Batch"
{

    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Page, Page::"Reservation Journal", 'OnPostBatchResJnlToLedger', '', false, false)]
    local procedure RunOnPostBatchResJnlToLedger(fromTable: Record "Reservation Jnl Line"; toTable: Record "Reservation Ledger Entry")
    begin

        repeat
            OnValidateResJnlRecord(fromTable);
            OnPostResJnlLineRecordToLedger(fromTable, toTable);
        until fromTable.Next() = 0;
        fromTable.DeleteAll();
    end;


    [IntegrationEvent(false, false)]
    local procedure OnValidateResJnlRecord(fromTable: Record "Reservation Jnl Line")
    begin
    end;


    [IntegrationEvent(false, false)]
    local procedure OnPostResJnlLineRecordToLedger(fromTable: Record "Reservation Jnl Line"; toTable: Record "Reservation Ledger Entry")
    begin
    end;

}