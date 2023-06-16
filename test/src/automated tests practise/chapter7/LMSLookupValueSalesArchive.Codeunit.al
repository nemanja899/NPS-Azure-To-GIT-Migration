codeunit 70051 "LMSLookupValue Sales Archive"
{
    // Subtype = Test;

    // [Test]
    procedure ArchiveSalesOrderWithLookupValue()
    begin
        LibraryLowerPermissions.AddPermissionSet('nemanjaPermisionSet');

        //[SCENARIO #0018] Archive sales order with lookup value
        ArchiveSalesDocumentWithLookupValue(Enum::"Sales Document Type"::Order);

    end;

    // [Test]
    procedure ArchiveSalesQuoteWithLookupValue()
    begin
        LibraryLowerPermissions.AddPermissionSet('nemanjaPermisionSet');
        //[SENARIO #0019] Archived sales quote has lookup value 
        ArchiveSalesDocumentWithLookupValue(Enum::"Sales Document Type"::Quote);
    end;

    // [Test]
    procedure ArchiveSalesReturnOrderWithLookupValue()
    begin
        LibraryLowerPermissions.AddPermissionSet('nemanjaPermisionSet');
        //[SCENARIO #0020] Archive sales return order with lookup value 
        ArchiveSalesDocumentWithLookupValue(Enum::"Sales Document Type"::"Return Order");
    end;

    local procedure ArchiveSalesDocumentWithLookupValue(DocumentType: Enum "Sales Document Type"): Code[20]
    var
        SalesHeader: Record "Sales Header";
    begin
        //[GIVEN] Sales document with lookup value
        CreateSalesDocumentWithLookupValue(SalesHeader, DocumentType);
        //[WHen] Sales document is achived
        ArchiveSalesDocument(SalesHeader);
        //[THen] Archived sales document has lookup value from sales document
        VerifyLookupValueOnSalesDocumentArchive(DocumentType, SalesHeader."No.", SalesHeader."Lookup Value Code", 1);

        exit(SalesHeader."No.");
    end;

    local procedure ArchiveSalesDocument(SalesHeader: Record "Sales Header")
    var
        ArchiveManagement: Codeunit ArchiveManagement;
    begin
        ArchiveManagement.ArchiveSalesDocument(SalesHeader);

    end;

    local procedure VerifyLookupValueOnSalesDocumentArchive(DocumentTypeParam: Enum "Sales Document Type"; SalesHeaderNo: Code[20]; LookupValueCode: Code[10]; VersionNo: Integer)
    begin

    end;

    local procedure CreateSalesDocumentWithLookupValue(var SalesHeader: Record "Sales Header"; DocumentType: Enum "Sales Document Type"): Code[10]
    begin
        LibrarySales.CreateSalesHeader(SalesHeader, DocumentType, '');
        SalesHeader.Validate("Lookup Value Code", CreateLookupValueCode());
        SalesHeader.Modify();
        exit(SalesHeader."Lookup Value Code");

    end;

    local procedure CreateLookupValueCode(): Code[10]
    var
        LookupValues: Record LookupValues;
    begin
        LookupValues.Init();
        LookupValues.Validate(Code, LibraryUtility.GenerateRandomCode(LookupValues.FieldNo(Code), Database::LookupValues));
        LookupValues.Insert();
        Commit();
        exit(LookupValues.Code);

    end;

    var
        LibrarySales: Codeunit "Library - Sales";
        LibraryUtility: Codeunit "Library - Utility";
        LibraryLowerPermissions: Codeunit "Library - Lower Permissions";



}