codeunit 70050 "LookupValue UT Sales Document"
{
    Subtype = Test;


    [Test]
    procedure AssignLookupValueToSalesHeader()
    var
        SalesHeader: Record "Sales Header";
    begin

        //[SCENARIO #0004] Assign lookup value to sales header page
        //[GIVEN] Lookup Value
        Initialize();
        //[GIVEN] Sa;es Header
        LibraryLowerPermissions.AddPermissionSet('nemanjaPermisionSet');

        CreateSalesHeader(SalesHeader);
        //[WHen] Set lookup value on sales header 
        SetLookupValueOnSalesHeader(SalesHeader);
        //[WHEN] Sales header has lookup value code field populated
        VerifyLookupValueOnSalesHeader(SalesHeader."Document Type", SalesHeader."No.", LookupValueCode);
    end;

    [Test]
    procedure AssignLookupValueToSalesQuoteDocument()
    var
        SalesHeader: Record "Sales Header";
        SalesQuoteDocument: TestPage "Sales Quote";
        DocumentNo: Code[20];
    begin
        //[SCENARIO #0006] Assign lookup value on sales quote document page
        //[GIVEN] Lookup Value
        Initialize();
        //[GIVEN] SAles Quote document page
        LibraryLowerPermissions.AddPermissionSet('nemanjaPermisionSet');

        CreateSalesQuoteDocument(SalesQuoteDocument);
        //[WHen] Set lookup value on sales page document 
        DocumentNo := SetLookupValueOnSalesQuoteDocument(SalesQuoteDocument);
        //[THEN] SAles Quote has lookup value code field populated
        VerifyLookupValueOnSalesHeader(Enum::"Sales Document Type"::Quote, DocumentNo, LookupValueCode);
    end;

    [Test]
    procedure AssignLookupValueToSalesOrderDocument()
    var
        SalesHeader: Record "Sales Header";
        SalesDocument: TestPage "Sales Order";
        DocumentNo: Code[20];
    begin
        //[SCENARIO #0007] Assign lookup value to sales order document page
        //[GIVEN] Lookup Value
        Initialize();
        LibraryLowerPermissions.AddPermissionSet('nemanjaPermisionSet');

        //[GIVEN] Sa;es Order document page
        CreateSalesOrderDocument(SalesDocument);
        //[WHen] Set lookup value on sales order document
        DocumentNo := SetLookupValueOnSalesOrderDocument(SalesDocument);
        //[THEN] Sales order has lookup value code field populated
        VerifyLookupValueOnSalesHeader(Enum::"Sales Document Type"::Order, DocumentNo, LookupValueCode);
    end;

    local procedure Initialize()

    begin
        if isInitialized then
            exit;
        LibraryLowerPermissions.AddPermissionSet('nemanjaPermisionSet');
        LookupValueCode := CreateLookupValueCode();
        isInitialized := true;
        Commit();

    end;

    local procedure CreateSalesHeader(var SalesHeader: Record "Sales Header")
    begin
        LibrarySales.CreateSalesHeader(SalesHeader, Enum::"Sales Document Type"::Invoice, '');
    end;



    local procedure CreateSalesOrderDocument(var SalesDocument: TestPage "Sales Order")
    begin
        SalesDocument.OpenNew();
    end;

    local procedure CreateSalesQuoteDocument(var SalesQuote: TestPage "Sales Quote")
    begin
        SalesQuote.OpenNew();
    end;

    local procedure SetLookupValueOnSalesOrderDocument(var SalesDocument: TestPage "Sales Order") DocumentNo: Code[20]
    begin
        Assert.IsTrue(SalesDocument."Lookup Value Code".Editable(), 'Editable');
        SalesDocument."Lookup Value Code".SetValue(LookupValueCode);
        DocumentNo := CopyStr(SalesDocument."No.".Value(), 1, MaxStrLen(DocumentNo));
        SalesDocument.Close();
    end;

    local procedure SetLookupValueOnSalesHeader(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.Validate("Lookup Value Code", LookupValueCode);
        SalesHeader.Modify();
    end;

    local procedure SetLookupValueOnSalesQuoteDocument(var SalesDocument: TestPage "Sales Quote") DocumentNo: Code[20]

    begin
        Assert.IsTrue(SalesDocument."Lookup Value Code".Editable(), 'Editable');
        SalesDocument."Lookup Value Code".SetValue(LookupValueCode);
        DocumentNo := CopyStr(SalesDocument."No.".Value(), 1, MaxStrLen(DocumentNo));
        SalesDocument.Close();
    end;

    local procedure VerifyLookupValueOnSalesHeader(DocumentType: Enum "Sales Document Type"; DocumentNo: Code[20]; LookupValueCodeParam: Code[10])
    var
        SalesHeader: Record "Sales Header";
        FieldOnTableTxt: Label '%1 on %2';
    begin
        SalesHeader.Get(DocumentType, DocumentNo);
        Assert.AreEqual(LookupValueCodeParam, SalesHeader."Lookup Value Code", StrSubstNo(FieldOnTableTxt, SalesHeader.FieldCaption("Lookup Value Code"), SalesHeader.TableCaption()));
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

    var
        Assert: Codeunit "Library Assert";
        LibraryUtility: Codeunit "Library - Utility";
        LibrarySales: Codeunit "Library - Sales";
        isInitialized: Boolean;
        LookupValueCode: Code[10];
        LibraryLowerPermissions: Codeunit "Library - Lower Permissions";

}