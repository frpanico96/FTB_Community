/**@frpanico
 * This class was thought to be used with the CometD library
 * To start listening for SFDC platform events
 * #### This class is not currently in use ####
 */
public with sharing class FTB_LC_CometD 
{
    @AuraEnabled(cacheable = true)
    public static string getSessionId()
    {
        String sessionId = UserInfo.getSessionId();
        return sessionId;
    }
}
