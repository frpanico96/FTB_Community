public with sharing class FTB_TRH_Queue extends FTB_TRH_TriggerHandler
{
    private static FTB_UTL_Utils ftbUtils = new FTB_UTL_Utils();
    
    public override void afterInsert()
    {
        FTB_Queue__c currentQueue = (FTB_Queue__c) Trigger.new[0];
        List<FTB_Queue__c> queues = ftbUtils.readSObject([SELECT Id FROM FTB_Queue__c WHERE FTB_Operation__c = :currentQueue.FTB_Operation__c]);
        
        if(!queues.isEmpty()) return;
        Map<String, String> messageMap = (Map<String, String>) JSON.deserialize(currentQueue.FTB_Payload__c, Map<String,String>.class);
        messageMap.put('queueId', currentQueue.Id);
        FTB_CMT_IntegrationConfiguration__mdt getConfiguration = FTB_CMT_IntegrationConfiguration__mdt.getInstance(currentQueue.FTB_Operation__c);
        if(getConfiguration == null) return;
        SObject platEvent = (SObject) Type.forName(getConfiguration.FTB_ClassName__c).newInstance();
        platEvent.put('FTB_Payload__c', JSON.serialize(messageMap));
        Eventbus.publish(platEvent);    
    }
}
