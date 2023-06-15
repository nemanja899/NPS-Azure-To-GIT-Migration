codeunit 70049 "LMSLookupValue UT Customer"
{
    Subtype = Test;
    // TestPermissions = Disabled;

    [Test]
    procedure AssignLookupValueToCustomer()
    var
        Customer: Record Customer;
        LookupValueCode: Code[10];
    begin
        //[scenario #0001] Assign Lookup Value to Customer
        //[GIVEN] Lookup value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] Customer 
        CreateCustomer(Customer);
        //[WHEN] Set lookup value on customer
        SetLookupValueOnCustomer(Customer, LookupValueCode);
        //[THEN] Customer has lookup value code field populated
        VerifyLookupValueOnCustomer(Customer."No.", LookupValueCode);
    end;


    [Test]
    procedure AssignNonExistLookupValueToCustomer()
    var
        Customer: Record Customer;
        LookupValueCode: Code[10];

    begin
        //[scenario #0002] Assign non-existent Lookup Value to Customer
        //[GIVEN] Non-exist Lookup value
        LookupValueCode := 'BN1234';
        //[GIVEN] Customer
        CreateCustomer(Customer);
        //[WHEN] Set non-existent Lookup value on customer
        asserterror SetLookupValueOnCustomer(Customer, LookupValueCode);
        //[THEN] Throw error message 
        VerifyNonExistentLookupValueError(LookupValueCode);

    end;


    [Test]
    [HandlerFunctions('HandleCustomerTemplList')]
    procedure AssignLookupValueToCustomerCard()
    var
        CustomerCard: TestPage "Customer Card";
        CustomerNo: Code[20];
        LookupValueCode: Code[10];
        LibraryLowerPermissions: Codeunit "Library - Lower Permissions";

    begin
        LibraryLowerPermissions.AddPermissionSet('nemanjaPermisionSet');

        //[Scenario #003] Assign lookup value on customer card
        //[GIVEN] Lookup value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] Customer card
        CreateCustomerCard(CustomerCard);
        //[WHEN] Set lookup value on customer card
        CustomerNo := SetLookupValueOnCustomerCard(CustomerCard, LookupValueCode);
        //[THEN] CUstomer has lookup value field populated
        VerifyLookupValueOnCustomer(CustomerNo, LookupValueCode);
    end;

    local procedure CreateCustomerCard(var CustomerCard: TestPage "Customer Card")
    begin
        CustomerCard.OpenNew();
    end;

    local procedure SetLookupValueOnCustomerCard(var CustomerCard: TestPage "Customer Card"; LookupValueCode: Code[10]) CustomerNo: Code[20]

    begin
        Assert.IsTrue(CustomerCard."Lookup Value Code".Editable(), 'Editable');
        CustomerCard."Lookup Value Code".SetValue(LookupValueCode);
        CustomerNo := CustomerCard."No.".Value();
        CustomerCard.Close();

    end;

    local procedure CreateLookupValueCode(): Code[10]
    var
        LookupValue: Record LookupValues;

    begin
        LookupValue.Init();
        LookupValue.Validate(Code, LibraryUtility.GenerateRandomCode(LookupValue.FieldNo(Code), Database::LookupValues));
        LookupValue.Insert();
        exit(LookupValue.Code);

    end;

    local procedure CreateCustomer(var Customer: Record Customer)
    begin
        LIbrarySales.CreateCustomer(Customer);
    end;

    local procedure SetLookupValueOnCustomer(var Customer: Record Customer; LookupValueCode: Code[10])
    begin
        Customer.Validate("Lookup Value Code", LookupValueCode);
        Customer.Modify();
    end;

    local procedure VerifyLookupValueOnCustomer(CustomerNo: Code[20]; LookupValueCode: Code[10])
    var
        Customer: Record Customer;
        FIeldOnTableTxt: Label '%1 on %2';
    begin
        Customer.Get(CustomerNo);
        Assert.AreEqual(LookupValueCode, Customer."Lookup Value Code", StrSubstNo(FIeldOnTableTxt, Customer.FieldCaption("Lookup Value Code"), Customer.TableCaption()));
    end;

    local procedure VerifyNonExistentLookupValueError(LookupValueCode: Code[10])

    var
        Customer: Record Customer;
        LookupValue: Record LookupValues;
        ValueCannotBeFoundInTableTxt: Label 'The filed %1 of table %2 contains a value (%3) that cannot be found in the related table (%4)..';
    begin

        Assert.ExpectedError(StrSubstNo(ValueCannotBeFoundInTableTxt, Customer.FieldCaption("Lookup Value Code"), Customer.TableCaption(), LookupValueCode, LookupValue.TableCaption()));
    end;

    [ModalPageHandler]
    procedure HandleCustomerTemplList(var CustomerTemplList: TestPAge "Select Customer Templ. List")
    begin
        CustomerTemplList.OK.Invoke();
    end;

    var
        LibraryUtility: Codeunit "Library - Utility";
        LIbrarySales: Codeunit "Library - Sales";

        Assert: Codeunit Assert;
}

