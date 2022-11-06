trigger FTB_HomeMessageEvt on FTB_HomeMessage__e (after insert) 
{
  FTB_TRH_HomeMessageEvt triggerHandler = new FTB_TRH_HomeMessageEvt();
  triggerHandler.run();
}