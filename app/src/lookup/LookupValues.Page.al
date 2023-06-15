page 50105 "LookupValues"
{
    PageType = List;
    SourceTable = "LookupValues";
    Caption = 'Lookup Values';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(RepeaterControl)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies a code to identify this lookup value.';
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ToolTip = 'Specifies a text to describe the lookup value.';
                    ApplicationArea = All;
                }
            }
        }
    }
}