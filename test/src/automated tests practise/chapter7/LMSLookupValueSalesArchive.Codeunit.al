codeunit 70051 "LMSLookupValue Sales Archive"
{
    Subtype = Test;

    [Test]
    procedure ArchiveSalesOrderWithLookupValue()
    begin
        //[SCENARIO #0018] Archive sales order with lookup value
        ArchiveSalesDocumentWithLookupValue(Enum::"Sales Document Type"::Order);

    end;

    [Test]
    procedure ArchiveSalesQuoteWithLookupValue()
    begin
        //[SENARIO #0019] Archived sales quote has lookup value 
        ArchiveSalesDocumentWithLookupValue(Enum::"Sales Document Type"::Quote);
    end;

    [Test]
    procedure ArchiveSalesReturnOrderWithLookupValue()
    begin
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
        VerifyLookupValueOnSalesDOcumentArchive(DocumentType, SalesHeader."No.", SalesHeader."Lookup Value Code", 1);

        exit(SalesHeader."No.");
    end;

    local procedure ArchiveSalesDocument(SalesHeader: Record "Sales Header")
    begin

    end;

    local procedure VerifyLookupValueOnSalesDOcumentArchive(DocumentTypeParam: Enum "Sales Document Type"; SalesHeaderNo: Code[20]; LookupValueCode: Code[10]; VersionNo: Integer)
    begin

    end;

    local procedure CreateSalesDocumentWithLookupValue(var SalesHeader: Record "Sales Header"; DocumentType: Enum "Sales Document Type")
    begin

    end;
}