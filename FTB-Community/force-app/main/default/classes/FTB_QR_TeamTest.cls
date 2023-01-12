/**@frpanico
 * Test class for FTB_QR_Team
 */
@isTest
public with sharing class FTB_QR_TeamTest
{
    @TestSetup
    static void setup()
    {
        List<FTB_User__c> userList = FTB_UTL_DataFactory.createUser(true, 1);
        List<FTB_Championship__c> championshipList = FTB_UTL_DataFactory.createChampionships(true, 1);
        List<FTB_Team__c> teamList = FTB_UTL_DataFactory.createTeam(false, 1, championshipList[0].Id);
        teamList[0].FTB_User__c = userList[0].Id;
        insert teamList;
        List<FTB_Player__c> playerList = FTB_UTL_DataFactory.createPlayers(false, 1);
        playerList[0].FTB_Team__c = teamList[0].Id;
        insert playerList;
        FTB_UTL_DataFactory.createSession(true, 1, userList[0].Id);
    }
    @isTest
    static void getTeamWithPlayersByUserSessionTest()
    {
        List<FTB_Session__c> sessionList = [SELECT Id,FTB_SessionId__c FROM FTB_Session__c];
        Test.startTest();
            List<FTB_Team__c> result = FTB_QR_Team.getTeamWithPlayersByUserSession(sessionList[0].FTB_SessionId__c);
        Test.stopTest();
        System.assertEquals(true, !result.isEmpty(), 'Team not found');
    }
}
