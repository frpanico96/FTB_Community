/**@frpanico
 * Test class for FTB_UTL_Team
 */
@isTest
public with sharing class FTB_UTL_TeamTest
{
    @TestSetup
    static void setup()
    {
        List<FTB_User__c> userList = FTB_UTL_DataFactory.createUser(true, 1);
        List<FTB_Championship__c> championshipList = FTB_UTL_DataFactory.createChampionships(true, 1);
        List<FTB_Team__c> teamList = FTB_UTL_DataFactory.createTeam(false, 2, championshipList[0].Id);
        teamList[0].FTB_User__c = userList[0].Id;
        teamList[1].FTB_User__c = userList[0].Id;
        insert teamList;  
    }
    @isTest
    static void getSetIdFromListTest()
    {
        List<FTB_Team__c> teamList = [SELECT Id FROM FTB_Team__c];
        Test.startTest();
            Set<String> result = FTB_UTL_Team.getSetIdFromList(teamList);
        Test.stopTest();
        System.assertEquals(true, !result.isEmpty(), 'Conversion not succeded');
    }    
}