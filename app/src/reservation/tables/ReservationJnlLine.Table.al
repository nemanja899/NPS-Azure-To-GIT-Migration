table 50103 "Reservation Jnl Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Golf Course No."; Code[20])
        {
            Caption = 'Golf Course No.';
            DataClassification = CustomerContent;
            TableRelation = "Golf Course";
        }
        field(3; "Date of Play"; Date)
        {
            Caption = 'Date of Play';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if (Rec."Date of Play" < Today) then
                    Error('Can not enter past date ');
            end;
        }

        field(4; "Type"; Enum "Reservation Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if Rec."Type" <> Enum::"Reservation Type"::Member then
                    Rec."Club Member No." := '';

                CalculateTotalFee();
            end;
        }
        field(5; "Club Member No."; Code[20])
        {
            Caption = 'Club Member No.';
            DataClassification = CustomerContent;
            TableRelation = "Club Member";
        }
        field(6; "No. of Reserved Players"; Integer)
        {
            Caption = 'No. Reserved Players';
            DataClassification = CustomerContent;
            MinValue = 1;
            trigger OnValidate()
            begin
                CalculateTotalFee();
            end;
        }
        field(7; "Total Fee"; Decimal)
        {
            Caption = 'Total Fee';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Tee TIme"; Time)
        {
            Caption = 'Tee Time';
            DataClassification = CustomerContent;
        }
        field(9; "No. of Actual Players"; Integer)
        {
            Caption = 'No. of Actual Players';
            DataClassification = CustomerContent;
            MinValue = 0;
            trigger OnValidate()
            begin
                if Rec."Date of Play" > Today then
                    Error('Can not fill number of players before they actually played');

                CalculateTotalFee();
            end;

        }
        field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    var
        MarketingSetup: Record "Marketing Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            MarketingSetup.Get();
            MarketingSetup.TestField("Contact Nos.");
            NoSeriesManagement.InitSeries(MarketingSetup."Contact Nos.", xRec."No.", 0D, "No.", "No. Series");
        end;
    end;

    local procedure CalculateTotalFee()

    var
        GolfCourse: Record "Golf Course";
        SurchargePerc: Decimal;

    begin
        GolfCourse.Get(Rec."Golf Course No.");
        if Rec.Type = Enum::"Reservation Type"::Comp then
            SurchargePerc := 0;
        if Rec.Type = Enum::"Reservation Type"::Member then
            SurchargePerc := 1;
        if Rec.Type = Enum::"Reservation Type"::Public then
            SurchargePerc := 1.1;

        if Rec.Type.AsInteger() > 0 then
            if Rec."No. of Actual Players" > 0 then
                Rec."Total Fee" := GolfCourse."Green Fee" * Rec."No. of Actual Players" * SurchargePerc
            else
                if Rec."No. of Reserved Players" > 0 then
                    Rec."Total Fee" := GolfCourse."Green Fee" * Rec."No. of Reserved Players" * SurchargePerc;


    end;



}