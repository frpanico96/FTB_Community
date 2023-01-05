public with sharing class FTB_TRH_HomeMessageEvt extends FTB_TRH_TriggerHandler 
{
    public override void afterInsert()
    {
        FTB_HomeMessage__e event = (FTB_HomeMessage__e) Trigger.new[0];
        Map<String, String> payload = (Map<String, String>) JSON.deserialize(event.FTB_Payload__c, Map<String,String>.class);

        String sessionId = payload.get('sessionId');
        String queueId = payload.get('queueId');

        String result = FTB_UTL_HomePageHome.fetchData(sessionId);

        FTB_PEV_NotificationMessage__e notification = new FTB_PEV_NotificationMessage__e();
        String errorCode = String.isNotBlank(result) ? 'HOM-0000' : 'HOM-0001';
        String errorDescr = String.isNotBlank(result) ? result : 'Unable to fetch data. Try again or contact your administrator';
        notification.FTB_SerializedMessage__c = serializeMessage(errorCode, errorDescr, sessionId);

        Eventbus.publish(notification);

        dequeue(new FTB_Queue__c(Id= queueId));
    }

    
}