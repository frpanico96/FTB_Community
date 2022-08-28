public with sharing class FTB_TRH_LoginMessageEvt extends FTB_TRH_TriggerHandler
{
    private static final String ERROR_MESSAGE = 'Unable to Login. Please contact the administrator.';
    private static final String SUCCESS_CODE = 'LOG-0000';
    private static final String ERROR_LOGIN_CODE = 'LOG-0001';
    private static final String ERROR_REGISTRATION_CODE = 'LOG-0002';
    private static final String ERROR_LOGIN_MESSAGE = 'User not found. If you are already registered check your username and password are correct. Otherwise if your are not yet register click the Sign On button';
    private static final String ERROR_REGISTRATION_MESSAGE = 'User already registered';
    private static FTB_UTL_Login loginUtl = new FTB_UTL_Login();
    private static FTB_UTL_Security securityUtl = new FTB_UTL_Security();
    
    public override void afterInsert()
    {
        FTB_LoginMessage__e event = (FTB_LoginMessage__e) Trigger.new[0];
        FTB_User__c newUser = new FTB_User__c();
        FTB_Session__c newSession = new FTB_Session__c();
        Map<String, String> credentials = (Map<String, String>) JSON.deserialize(event.FTB_Payload__c, Map<String,String>.class);
        FTB_PEV_NotificationMessage__e notification = new FTB_PEV_NotificationMessage__e();
        Boolean isSignIn = credentials.get('signtype')?.equalsIgnoreCase('signIn');
        String queueId = credentials.get('queueId');
        
        notification.FTB_Service__c = String.valueOf(FTB_ENM_Service.SIGN);

        newUser.FTB_Username__c = credentials.get('username');
        newUser.FTB_Password__c = securityUtl.ftbEncryption(credentials.get('password'));


        List<FTB_User__c> existingUsers = readSObject([SELECT Id,FTB_Password__c FROM FTB_User__c WHERE FTB_Username__c = :newUser.FTB_Username__c]);
        // LOG-0002 REGISTER WITH EXISTING USER
        if(!isSignIn && !existingUsers.isEmpty())
        {
            notification.FTB_SerializedMessage__c = serializedMessage(ERROR_REGISTRATION_CODE, ERROR_REGISTRATION_MESSAGE, newUser.FTB_Username__c);
            Eventbus.publish(notification);
            dequeue(queueId);
            return;
        }
        // LOG-0001 LOGIN WITHOUT EXISTING USER
        if(isSignIn && existingUsers.isEmpty())
        {
            notification.FTB_SerializedMessage__c = serializedMessage(ERROR_LOGIN_CODE, ERROR_LOGIN_MESSAGE, newUser.FTB_Username__c);
            Eventbus.publish(notification);
            dequeue(queueId);
            return;
        }
        //LOGIN WITH EXISTING USER
        if(isSignIn && !existingUsers.isEmpty())
        {
            // LOG-0000 SUCCESS LOGIN
            if(newUser.FTB_Password__c.equalsIgnoreCase(existingUsers[0].FTB_Password__c))
            {
                List<FTB_Session__c> userSessions = [SELECT Id,FTB_SessionId__c FROM FTB_Session__c WHERE FTB_IsActive__c = true];
                String sessionId;
                if(userSessions.isEmpty())
                {
                    sessionId = (loginUtl.generateUserSession(existingUsers[0].Id, newUser.FTB_Username__c)).FTB_SessionId__c;
                }
                else
                {
                    sessionId = userSessions[0].FTB_SessionId__c;
                }
                notification.FTB_SerializedMessage__c = serializedMessage(SUCCESS_CODE, sessionId, newUser.FTB_Username__c);
            }
            // LOG-0001 FAILED LOGIN
            else
            {
                notification.FTB_SerializedMessage__c = serializedMessage(ERROR_LOGIN_CODE, ERROR_LOGIN_MESSAGE, newUser.FTB_Username__c);
            }
            Eventbus.publish(notification);
            dequeue(queueId);
            return;
        }
        insertSObject(newUser);
        
        newUser = (FTB_User__c) readSObject([SELECT Id,FTB_Username__c FROM FTB_User__c WHERE FTB_Username__c = :newUser.FTB_Username__c LIMIT 1])[0];

        newSession = loginUtl.generateUserSession(newUser.Id, newUser.FTB_Username__c);

        insertSObject(newSession);

        dequeue(queueId);

        notification.FTB_SerializedMessage__c = serializedMessage(SUCCESS_CODE, newSession.FTB_SessionId__c, newUser.FTB_Username__c);  

        Eventbus.publish(notification);
    }

    private void dequeue(String queueId)
    {
        FTB_Queue__c workedQueue = new FTB_Queue__c(Id = queueId);
        deleteSObject(workedQueue);
    }

    private String serializedMessage(String code, String description, String identificationKey)
    {
        return JSON.serialize(new FTB_WRP_OperationResult(code, description, identificationKey));
    }

}
