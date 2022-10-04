public with sharing class FTB_LC_CometD 
{
    @AuraEnabled(cacheable = true)
    public static string getSessionId()
    {
        String sessionId = UserInfo.getSessionId();
        return sessionId;
    }
}
