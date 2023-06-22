codeunit 70051 "LMSLookupValue Sales Archive"
{
    Subtype = Test;

    [Test]
    procedure ArchiveSalesOrderWithLookupValue()
    begin
        LibraryLowerPermissions.AddPermissionSet('nemanjaPermisionSet');

        //[SCENARIO #0018] Archive sales order with lookup value
        ArchiveSalesDocumentWithLookupValue(Enum::"Sales Document Type"::Order);

    end;

    [Test]
    procedure ArchiveSalesQuoteWithLookupValue()
    begin
        LibraryLowerPermissions.AddPermissionSet('nemanjaPermisionSet');
        //[SENARIO #0019] Archived sales quote has lookup value 
        ArchiveSalesDocumentWithLookupValue(Enum::"Sales Document Type"::Quote);
    end;

    [Test]
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

    local procedure VerifyLookupValueOnSalesDocumentArchive(DocumentTypeParam: Enum "Sales Document Type"; DocumentNo: Code[20]; LookupValueCode: Code[10]; VersionNo: Integer)
    var
        SalesHeaderArchive: Record "Sales Header Archive";
    begin
        FindSalesDocumentArchive(SalesHeaderArchive, DocumentTypeParam, DocumentNo);
        SalesHeaderArchive.SetRange("Version No.", VersionNo);
        SalesHeaderArchive.FindFirst();
        Assert.AreEqual(LookupValueCode, SalesHeaderArchive."Lookup Value Code", '');
    end;

    local procedure VerifyLookupValueOnSalesListArchive(DocumentType: Enum "Sales Document Type"; DocumentNo: Code[20])
    var
        SalesHeaderArchive: Record "Sales Header Archive";
        SalesListArchive: TestPage "Sales List Archive";
        FieldOnTableTxt: Label '1% on %2';

    begin
        SalesHeaderArchive.Get(DocumentType, DocumentNo, 1, 1);
        SalesListArchive.OpenNew();
        SalesListArchive.GoToRecord(SalesHeaderArchive);

        Assert.AreEqual(SalesHeaderArchive."Lookup Value Code", SalesListArchive."Lookup Value Code".Value(), StrSubstNo(FieldOnTableTxt, SalesHeaderArchive.FieldCaption("Lookup Value Code"), SalesHeaderArchive.TableCaption()));
    end;

    local procedure FindSalesDocumentArchive(var SalesHeaderArchive: Record "Sales Header Archive"; DocumentType: Enum "Sales Document Type"; DocumentNo: Code[20])
    begin
        SalesHeaderArchive.SetRange("Document Type", DocumentType);
        SalesHeaderArchive.SetRange("No.", DocumentNo);
        SalesHeaderArchive.FindFirst();
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


    [ConfirmHandler]
    procedure ConfirmHandlerYes(Question: Text[1024]; var Reply: Boolean);
    var
        ArchiveDocumentNo: Label 'Archive %1 no.: %2';
    begin
        Assert.ExpectedMessage(
            StrSubstNo(ArchiveDocumentNo,

            ),
            Question);
        Reply := true;
    end;

    [MessageHandler]
    procedure MessageHandler(Message: Text[1024]);
    var
        DocumentHasBeenArchivedTxt: Label 'Document %1 has been archived';
    begin
        Assert.ExpectedMessage(
            StrSubstNo(DocumentHasBeenArchivedTxt,
                ),
            Message);
    end;

    var
        LibrarySales: Codeunit "Library - Sales";
        LibraryUtility: Codeunit "Library - Utility";
        LibraryLowerPermissions: Codeunit "Library - Lower Permissions";

        Assert: Codeunit "Assert";

}