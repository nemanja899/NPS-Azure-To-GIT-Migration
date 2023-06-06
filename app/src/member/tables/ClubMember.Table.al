table 50102 "Club Member"
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
        field(2; "Name"; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; "Type"; Enum "Club Member Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(4; "Address"; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(5; "Status"; Enum "Member Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }

        field(6; "Total Reservations"; Integer)
        {
            Caption = 'Total Reservations';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Reservation Ledger Entry" where("Club Member No." = field("No."),
            "Date of Play" = field("Date Range")));
        }

        field(7; "Date Range"; Date)
        {
            Caption = 'Date Range';
            FieldClass = FlowFilter;
        }

        field(8; "Total Amount"; Decimal)
        {
            Editable = false;
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Reservation Ledger Entry"."Total Fee" where("Club Member No." = field("No."),
            "Date of Play" = field("Date Range")
            ));
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
        ReservationSetup: Record "Marketing Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            ReservationSetup.Get();
            ReservationSetup.TestField("Opportunity Nos.");
            NoSeriesMgmt.InitSeries(ReservationSetup."Opportunity Nos.", xRec."No.", 0D, "No.", "No. Series");
        end;


    end;


}