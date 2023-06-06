page 50101 "Golf Courses"
{
    Caption = 'Golf Courses';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Golf Course";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Course Number';
                }

                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Course Name';
                }
                field("Address"; Rec."Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Course Address';
                }
                field("Green Fee"; Rec."Green Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Course amount charged for one person to play one round of golf ';
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


    actions
    {

        area(Promoted)
        {
            actionref(MyPromotedActionRef; MyAction)
            {
            }
        }
        area(navigation)
        {
            action(MyAction)
            {
                ApplicationArea = All;
                Caption = 'Reservation Ledger';
                Image = LedgerBook;
                RunObject = page "Reservation Ledger Entries";
                RunPageLink = "Golf Course No." = field("No.");
                ToolTip = 'Open Reservation Ledger';
            }
        }

    }

    // trigger OnOpenPage()
    // var
    //     DateRange: TextBuilder;


    // begin
    //     DateRange.Append('..');
    //     DateRange.Append(Format(Today, 0));
    //     Rec."Date Range" := DateRange.toText();
    // end;

}