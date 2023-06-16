permissionset 50101 nemanjaPermisionSet
{
    Assignable = true;
    Permissions = tabledata "Club Member"=RIMD,
        tabledata "Golf Course"=RIMD,
        tabledata LookupValues=RIMD,
        tabledata "Reservation Jnl Line"=RIMD,
        tabledata "Reservation Ledger Entry"=RIMD,
        table "Club Member"=X,
        table "Golf Course"=X,
        table LookupValues=X,
        table "Reservation Jnl Line"=X,
        table "Reservation Ledger Entry"=X,
        codeunit "Res. Jnl. Line - Check Line"=X,
        codeunit "Res. Jnl. Line - Post Batch"=X,
        codeunit "Res. Jnl. Line - Post Line"=X,
        page "Club Members"=X,
        page "Golf Courses"=X,
        page LookupValues=X,
        page "Reservation Journal"=X,
        page "Reservation Ledger Entries"=X;
}