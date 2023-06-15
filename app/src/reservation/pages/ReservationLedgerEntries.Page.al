page 50104 "Reservation Ledger Entries"
{
    Caption = 'Reservation Ledger Entries';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Reservation Ledger Entry";
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Reservation Number';
                }
                field("Golf Course No."; Rec."Golf Course No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Golf Course Number';
                }
                field("Date of Play"; Rec."Date of Play")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Golf Reservation Date';
                }
                field("Reservation Type"; Rec."Reservation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Reservation Type';
                }
                field("Club Member No."; Rec."Club Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Club Member Number';
                }
                field("No. of Players"; Rec."No. of Players")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Number Player that played golf';
                }
                field("Total Fee"; Rec."Total Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Total Fee Amount';
                }
                field("Tee Time"; Rec."Tee Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies reserved starting time for round of golf';

                }

            }
        }
    }

}