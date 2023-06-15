pageextension 50102 "Sales Order Page Ext" extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field("Lookup Value Code"; Rec."Lookup Value Code")
            {
                ToolTip = 'Lookup Value Code';
                ApplicationArea = all;
            }
        }
    }
}