codeunit 70046 "LMSReservation Tests"
{
    Subtype = Test;

    var
        LibraryRandom: Codeunit "Library - Random";
        Assert: Codeunit Assert;
        LibraryUtility: Codeunit "Library - Utility";


    [Test]
    procedure TestActualPlayersTotalFeePublic()
    var
        ReservationJnlLine: Record "Reservation Jnl Line";
        GolfCourse: Record "Golf Course";
        TotalFeePublicErr: Label 'Public Members have 10% surcharge rate';
        actualTotalFee: Decimal;
    begin
        //[SCENARIO] Testing if total fee is correct based on no. of  actual players

        //[GIVEN] ReservationJnlLine types exist as member value
        GolfCourse.Init();
        GolfCourse.Validate(Address, LibraryRandom.RandText(20));
        GolfCourse.Validate("Name", LibraryRandom.RandText(20));
        GolfCourse.Validate("Green Fee", LibraryRandom.RandDec(5, 0));
        GolfCourse."No." := LibraryUtility.GetGlobalNoSeriesCode();
        GolfCourse.Insert();

        ReservationJnlLine.Init();
        ReservationJnlLine.Validate(Type, Enum::"Reservation Type"::Public);
        ReservationJnlLine.Validate("Date of Play", Today);
        ReservationJnlLine."Golf Course No." := GolfCourse."No.";
        ReservationJnlLine.Validate("No. of Actual Players", LibraryRandom.RandIntInRange(1, 50));

        ReservationJnlLine."No." := LibraryUtility.GetGlobalNoSeriesCode();
        ReservationJnlLine.Insert();
        actualTotalFee := calculateTotalFee(ReservationJnlLine.Type, ReservationJnlLine."No. of Actual Players", GolfCourse."Green Fee");
        //[WHEN] when Customer No. is not specified

        Assert.AreEqual(actualTotalFee, ReservationJnlLine."Total Fee", TotalFeePublicErr);

        //[THEN] then expected value
    end;


    local procedure calculateTotalFee(ReservationType: Enum "Reservation Type"; NoPlayers: Integer; GreenFee: Decimal): Decimal
    begin

        if ReservationType = "Reservation Type"::Comp then
            exit(0);
        if ReservationType = "Reservation Type"::Public then
            exit(NoPlayers * GreenFee * 1.1);
        if ReservationType = "Reservation Type"::Member then
            exit(NoPlayers * GreenFee);
    end;


}