/**@frpanico
 * Test class for FTB_QR_Championship
 */
@isTest
public with sharing class FTB_QR_ChampionshipTest 
{
    @TestSetup
    static void setup()
    {
        FTB_UTL_DataFactory.createChampionships(true, 1);
    }
    @isTest
    static void getChampionshipsWithTeamsByIdSetTest()
    {
        List<FTB_Championship__c> championships = [SELECT Id FROM FTB_Championship__c];
        Set<Id> testSet = new Set<Id>();
        for(FTB_Championship__c championship : championships)
        {
            testSet.add(championship.Id);
        }
        Test.startTest();
            List<FTB_Championship__c> result = FTB_QR_Championship.getChampionshipsWithTeamsByIdSet(testSet);
        Test.stopTest();
        System.assertEquals(true, !result.isEmpty(), 'Championship not retrieved');
    }
}
