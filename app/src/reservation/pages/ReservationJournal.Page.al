page 50103 "Reservation Journal"
{
    Caption = 'Reservation Journal';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Reservation Jnl Line";

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
                    ToolTip = 'Specifies Course Number';

                }
                field("Date of Play"; Rec."Date of Play")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Date of Play';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Reservation Type';
                }

                field("Club Member No."; Rec."Club Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Club Member Number';
                    Editable = Rec.Type = Enum::"Reservation Type"::Member;
                }
                field("No. of Reserved Players"; Rec."No. of Reserved Players")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Number of Reserved Players';
                }
                field("Total Fee"; Rec."Total Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Total Fee';
                }

                field("Tee Time"; Rec."Tee Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies reserved starting time for round of golf';
                }

                field("No. of Actual Players"; Rec."No. of Actual Players")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Number of Actual Players that played';
                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Post';
                Image = LedgerBook;
                ToolTip = 'Post Reservation Journal to Ledger';

                trigger OnAction()
                var
                    ResJnlLists: Record "Reservation Jnl Line";
                    ResLdgEnt: Record "Reservation Ledger Entry";
                begin
                    if Confirm('Are you sure you want to post Journal in Ledger') then begin
                        ResJnlLists.SetFilter("No.", '*');
                        ResJnlLists.FindSet();
                        OnPostBatchResJnlToLedger(ResJnlLists, ResLdgEnt);
                        Message('Posting Successfull');
                    end;
                end;
            }
        }
    }

    [IntegrationEvent(false, false)]
    local procedure OnPostBatchResJnlToLedger(fromTable: Record "Reservation Jnl Line"; toTable: Record "Reservation Ledger Entry");
    begin
    end;


}