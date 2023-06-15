codeunit 70047 "LMSHandler Functions"
{

    Subtype = Test;


    [Test]
    [HandlerFunctions('MyMessageHandler')]
    procedure MyMessageTestFunction()
    begin
        Message('MyMessageHandlerFunctions');
    end;


    [MessageHandler]
    procedure MyMessageHandler(Message: Text[1024])
    begin

    end;
}