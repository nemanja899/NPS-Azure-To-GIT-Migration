table 50104 "Reservation Ledger Entry"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            Editable = false;
        }
        field(2; "Golf Course No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Golf Course No.';
            TableRelation = "Golf Course";
            Editable = false;
        }
        field(3; "Date of Play"; Date)
        {
            Caption = 'Date of Play';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(4; "Reservation Type"; Enum "Reservation Type")
        {
            Caption = 'Reservation Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Club Member No."; Code[20])
        {
            Caption = 'Club Member No.';
            DataClassification = CustomerContent;
            TableRelation = "Club Member";
            Editable = false;
        }
        field(6; "No. of Players"; Integer)
        {
            Caption = 'No. of Players';
            DataClassification = CustomerContent;
            MinValue = 1;
            Editable = false;
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
            Editable = false;
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
            SumIndexFields = "Total Fee";
        }

    }

    var
        MarketingSetup: Record "Marketing Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            MarketingSetup.Get();
            MarketingSetup.TestField("Campaign Nos.");
            NoSeriesManagement.InitSeries(MarketingSetup."Campaign Nos.", xRec."No.", 0D, "No.", "No. Series");
        end;
    end;



}