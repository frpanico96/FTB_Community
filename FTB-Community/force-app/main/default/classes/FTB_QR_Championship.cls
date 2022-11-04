public with sharing class FTB_QR_Championship
{

    public static List<FTB_Championship__c> getChampionshipsWithTeamsByIdSet(Set<Id> championshipIds)
    {
        return readChampionship
        (
            [SELECT Id, 
            Name, 
            (SELECT Name, FTB_Win__c, FTB_Loss__c, FTB_Ranking__c FROM FTB_Teams__r) 
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
