tableextension 50103 "SalesHeaderArchive TableExt" extends "Sales Header Archive"
{
    fields
    {
        field(50000; "Lookup Value Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Lookup Value Code';
            TableRelation = LookupValues;
        }

    }

}