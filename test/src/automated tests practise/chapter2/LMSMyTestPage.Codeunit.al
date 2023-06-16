codeunit 70048 "LMSMy Test Page"
{
    Subtype = Test;

    [Test]
    procedure MyFirstTestPageFunction()
    var
        PaymentTerms: TestPage "Payment Terms";
    begin
        PaymentTerms.OpenView();
        PaymentTerms.Last();
        PaymentTerms.Code.AssertEquals('LUC');
        PaymentTerms.Close();
    end;


    [Test]
    procedure MySecondTestPageFunction()
    var
        PaymentTerms: TestPage "Payment Terms";
    begin
        PaymentTerms.OpenNew();
        PaymentTerms.Code.SetValue('LUC');
        PaymentTerms."Discount %".SetValue('56');
        PaymentTerms.Description.SetValue(PaymentTerms.Code.Value());
        Error('Code: %1 \ Dicount %: %2 \Description: %3', PaymentTerms.Code.Value(), PaymentTerms."Discount %".Value(), PaymentTerms.Description.Value());
        PaymentTerms.Close();
    end;
}