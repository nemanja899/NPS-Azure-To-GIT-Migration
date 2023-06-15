pageextension 50104 "SalesQuoteArchive Page Ext" extends "Sales Quote Archive"
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