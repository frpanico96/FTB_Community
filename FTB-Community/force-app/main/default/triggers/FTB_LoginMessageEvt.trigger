trigger FTB_LoginMessageEvt on FTB_LoginMessage__e(after insert) 
{
  FTB_TRH_LoginMessageEvt triggerHandler = new FTB_TRH_LoginMessageEvt();
  triggerHandler.run();
}