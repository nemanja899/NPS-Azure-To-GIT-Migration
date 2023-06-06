table 50101 "Golf Course"
{

    Caption = 'Golf Course';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;

        }
        field(2; "Name"; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; "Address"; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(4; "Green Fee"; Decimal)
        {
            Caption = 'Green Fee';
            DataClassification = ToBeClassified;
        }

        field(5; "Total Reservations"; Integer)
        {
            Caption = 'Total Reservations';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Reservation Ledger Entry" where("Golf Course No." = field("No."),
            "Date of Play" = field("Date Range")));

        }

        field(6; "Total Amount"; Decimal)
        {
            Editable = false;
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Reservation Ledger Entry"."Total Fee" where("Golf Course No." = field("No."),
            "Date of Play" = field("Date Range")
            ));
        }

        field(7; "Date Range"; Date)
        {
            Caption = 'Date Range';
            FieldClass = FlowFilter;
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
            MarketingSetup.TestField("Segment Nos.");
            NoSeriesManagement.InitSeries(MarketingSetup."Segment Nos.", xRec."No.", 0D, "No.", "No. Series");
        end;

    end;


}