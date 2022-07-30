trigger FTB_Queue on FTB_Queue__c (after insert, before delete) 
{
  FTB_TRH_Queue queueHandler = new FTB_TRH_Queue();
  queueHandler.run();
}