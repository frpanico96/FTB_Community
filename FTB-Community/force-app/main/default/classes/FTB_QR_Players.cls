/*@frpanico 2022-02-15
 * Query class for the Player Custom Object
 * This class holds all the useful query for the object
 */
public with sharing class FTB_QR_Players {

    /* Returns all players in the database */
    public static List<FTB_Player__c> getAllPlayers()
    {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(accessType.READABLE, [SELECT Id FROM FTB_Player__c]);
        return (securityDecision.getRecords());
    }
}
