/*@frpanico 2022-02-15
 *FTB
 *Query Class
 *For Player Object
 */
public with sharing class FTB_QR_Players {

    /* Returns all players in the database */
    public static List<FTB_Player__c> getAllPlayers()
    {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(accessType.READABLE, [SELECT Id FROM FTB_Player__c]);
        return (securityDecision.getRecords());
    }
}
