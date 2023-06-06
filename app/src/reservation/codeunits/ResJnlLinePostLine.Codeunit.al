codeunit 50102 "Res. Jnl. Line - Post Line"
{
    procedure RunOnPostResJnlLineRecordToLedger(fromTable: Record "Reservation Jnl Line"; toTable: Record "Reservation Ledger Entry")
    begin
        toTable.Init();
        toTable."Golf Course No." := fromTable."Golf Course No.";
        toTable."Reservation Type" := fromTable.Type;
        toTable."Club Member No." := fromTable."Club Member No.";
        toTable."Date of Play" := fromTable."Date of Play";
        toTable."No. of Players" := fromTable."No. of Actual Players";
        toTable."Tee TIme" := fromTable."Tee TIme";
        toTable."Total Fee" := fromTable."Total Fee";
        toTable.Insert(true);

    end;

}