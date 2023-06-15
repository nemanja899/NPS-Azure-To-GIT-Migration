pageextension 50103 "Sales Quote Page Ext" extends "Sales Quote"
{
    layout
    {
        addlast(General)
        {
            field("Lookup Value Code"; Rec."Lookup Value Code")
            {
                ApplicationArea = All;
                ToolTip = 'Lookup Value Code';
            }

        }

    }
}