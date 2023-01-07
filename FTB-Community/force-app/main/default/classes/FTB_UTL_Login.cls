/**@frpanico
 * Utility Class for the Login
 */
public with sharing class FTB_UTL_Login extends FTB_UTL_Utils
{
    /**@frpanico
     * This method generate user session if none active is existing
     */
    public FTB_Session__c generateUserSession(String userId, String username)
    {
        FTB_Session__c newSession = new FTB_Session__c();
        List<FTB_Session__c> existingSession = [SELECT FTB_SessionId__c FROM FTB_Session__c WHERE FTB_User__c = :userId AND FTB_IsActive__c = true];
        if(!existingSession.isEmpty())
        {
            return existingSession[0];
        }
        newSession.FTB_User__c = userId;
        newSession.FTB_SessionId__c = generateSessionId(username);
        
        return newSession;
    }
}
