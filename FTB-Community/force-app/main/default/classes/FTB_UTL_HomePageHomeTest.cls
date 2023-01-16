/**@frpanico
 * Test class for FTB_UTL_HomePageHome
 */
@isTest
public with sharing class FTB_UTL_HomePageHomeTest
{
    @TestSetup
    static void setup()
    {
        List<FTB_User__c> userList = FTB_UTL_DataFactory.createUser(true, 1);
        List<FTB_Session__c> sessionList = FTB_UTL_DataFactory.createSession(true, 1, userList[0].Id);
        List<FTB_Championship__c> championshipList = FTB_UTL_DataFactory.createChampionships(true, 1);
        List<FTB_Team__c> teamList = FTB_UTL_DataFactory.createTeam(false, 2, championshipList[0].Id);
        teamList[0].FTB_User__c = userList[0].Id;
        teamList[1].FTB_User__c = userList[0].Id;
        insert teamList;
        List<FTB_Player__c> playerList = FTB_UTL_DataFactory.createPlayers(false, 4);
        playerList[0].FTB_Team__c = teamList[0].Id;
        playerList[1].FTB_Team__c = teamList[0].Id;
        playerList[2].FTB_Team__c = teamList[1].Id;
        playerList[3].FTB_Team__c = teamList[1].Id;
        insert playerList;
        List<FTB_Calendar__c> calendarList = FTB_UTL_DataFactory.createCalendar(false, 1, championshipList[0].Id);
        List<Map<String,String>> pairings = new List<Map<String,String>>{
            new Map<String,String>{'home' => teamList[0].Id, 
                'homeId' => teamList[0].id, 
                'away' => teamList[1].Id,
                'awayId' => teamList[1].id},
            new Map<String,String>{'home' => teamList[1].Id,
                'homeId' => teamList[1].Id, 
                'away' => teamList[0].Id,
                'awayId' => teamList[0].Id}
        };
        calendarList[0].FTB_Pairings__c = JSON.serialize(pairings);
        calendarList[0].FTB_StartDate__c = System.today();
        calendarList[0].FTB_EndDate__c = System.today().addDays(1);
        insert calendarList;
    }
    @isTest
    static void fetchDataTest()
    {
        List<FTB_Session__c> sessionList = [SELECT FTB_SessionId__c FROM FTB_Session__c];
        Test.startTest();
            String result = FTB_UTL_HomePageHome.fetchData(sessionList[0].FTB_SessionId__c);
        Test.stopTest();
        System.assertEquals(true, String.isNotBlank(result), 'Data not fetched');
    }
}