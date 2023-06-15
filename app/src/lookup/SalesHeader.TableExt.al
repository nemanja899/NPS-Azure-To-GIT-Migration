tableextension 50102 "Sales Header Table Ext" extends "Sales Header"
{
    fields
    {
        field(50000; "Lookup Value Code"; Code[10])
        {
            Caption = 'Lookup Value Code';
            DataClassification = ToBeClassified;
            TableRelation = LookupValues;

        }


    }

}