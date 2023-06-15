pageextension 50105 "SalesQuoteArchives" extends "Sales Quote Archives"
{
    layout
    {
        addfirst(Control1)
        {
            field("Lookup Value Code"; Rec."Lookup Value Code")
            {
                ApplicationArea = All;
                ToolTip = 'Lookup Value Code';
            }

        }

    }
}