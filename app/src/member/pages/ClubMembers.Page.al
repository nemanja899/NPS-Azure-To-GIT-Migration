page 50102 "Club Members"
{
    Caption = 'Club Members';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Club Member";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Club Member Number';
                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Club Member Name';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Club Member Type';
                }
                field("Address"; Rec."Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Club Member Address';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Club Member Status';
                }

                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Total Amount from Data range';
                    DrillDownPageId = "Reservation Ledger Entries";
                    LookupPageId = "Reservation Ledger Entries";
                    Lookup = true;
                }
                field("Total Reservations"; Rec."Total Reservations")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Total Reservations from Data range';
                    DrillDownPageId = "Reservation Ledger Entries";
                    LookupPageId = "Reservation Ledger Entries";
                    Lookup = true;

                }


            }
        }
    }

}