public with sharing class FTB_TRH_LoginMessageEvt extends FTB_TRH_TriggerHandler
{
    public override void afterInsert()
    {
        FTB_LoginMessage__e event = (FTB_LoginMessage__e) Trigger.new[0];
        /* Happy Flow */
        FTB_User__c newUser = new FTB_User__c();
        FTB_Session__c newSession = new FTB_Session__c();
        Map<String, String> credentials = (Map<String, String>) JSON.deserialize(event.FTB_Payload__c, Map<String,String>.class);

        newUser.FTB_Username__c = credentials.get('username');
        newUser.FTB_Password__c = credentials.get('password');

        insertSObject(newUser);
        
        newUser = (FTB_User__c) readSObject([SELECT Id FROM FTB_User__c WHERE FTB_Username__c = :newUser.FTB_Username__c LIMIT 1])[0];

        newSession.FTB_User__c = newUser.Id;
        newSession.FTB_SessionId__c = generateSessionId(credentials.get('password'));

        insertSObject(newSession);

        FTB_Queue__c workedQueue = new FTB_Queue__c(Id = credentials.get('queueId'));
        deleteSObject(workedQueue);

        FTB_PEV_NotificationMessage__e notification = new FTB_PEV_NotificationMessage__e();
        notification.FTB_SerializedMessage__c = 'SUCCESS';
        notification.FTB_Service__c = String.valueOf(FTB_ENM_Service.SIGN);

        Eventbus.publish(notification);

    }

}
