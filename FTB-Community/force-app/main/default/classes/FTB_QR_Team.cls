/*@frpanico 
 * Query class for the Team Custom Object
 * This class holds all the useful query for the object
 */
public with sharing class FTB_QR_Team 
{
    public static List<FTB_Team__c> getTeamWithPlayersByUserSession(String sessionId)
    {
        return readTeam
        (
            [SELECT Id, 
            Name,
            FTB_ShortName__c,
            FTB_Ranking__c,
            FTB_Win__c,
            FTB_Loss__c, 
            FTB_Championship__c,
            (SELECT Id,
            FTB_FullName__c,
            FTB_Score__c,
            FTB_Position__c
            FROM FTB_Players__r)
            FROM FTB_Team__c 
            WHERE FTB_User__c IN (Select FTB_User__c FROM FTB_Session__c WHERE FTB_SessionId__c = :sessionId)]
        );
    }


    private static List<FTB_Team__c> readTeam(List<FTB_Team__c> teamList)
    {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.READABLE, teamList);
        return securityDecision.getRecords();
    }
}
