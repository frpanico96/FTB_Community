/**@frpanico
 * Query class for the Championship Custom Object
 * This class holds all the useful query for the object
 */
public with sharing class FTB_QR_Championship
{

    public static List<FTB_Championship__c> getChampionshipsWithTeamsByIdSet(Set<Id> championshipIds)
    {
        return readChampionship
        (
            [SELECT Id, 
            Name, 
            (SELECT Name, FTB_Championship__c, FTB_Win__c, FTB_Loss__c, FTB_Ranking__c FROM FTB_Teams__r ORDER BY FTB_Ranking__c ASC),
            (SELECT FTB_Championship__c,FTB_Pairings__c, FTB_RealPairings__c, FTB_NumberOfGames__c FROM FTB_Calendars__r 
                WHERE FTB_StartDate__c <= TODAY AND FTB_EndDate__c > TODAY) 
            FROM FTB_Championship__c 
            WHERE Id IN :championshipIds]
        );
    }

    private static List<FTB_Championship__c> readChampionship(List<FTB_Championship__c> championshipList)
    {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.READABLE, championshipList);
        return securityDecision.getRecords();
    }
}
