/**@frpanico
 * Test class for FTB_UTL_Calendar
 */
@isTest
public with sharing class FTB_UTL_CalendarTest
{
    @TestSetup
    static void makeData()
    {
        List<FTB_Championship__c> championshipList = FTB_UTL_DataFactory.createChampionships(true, 1);
        List<FTB_User__c> userList = FTB_UTL_DataFactory.createUser(true, 1);
        List<FTB_Team__c> teamList = FTB_UTL_DataFactory.createTeam(false, 2, championshipList[0].Id);
        teamList[0].FTB_User__c = userList[0].Id;
        teamList[1].FTB_User__c = userList[0].Id;
        insert teamList;
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
        insert calendarList;
    }
    @isTest
    static void getNextOpponentTest()
    {
        List<FTB_Team__c> teamList = [SELECT Id, FTB_Championship__c FROM FTB_Team__c];
        List<FTB_Calendar__c> calendarList = [SELECT Id, FTB_Championship__c, FTB_Pairings__c FROM FTB_Calendar__c];
        Test.startTest();
            FTB_WRP_Utils.HomePageHomeCalendar resultOne = FTB_UTL_Calendar.getNextOpponent(calendarList[0], teamList[0]);
            FTB_WRP_Utils.HomePageHomeCalendar resultTwo = FTB_UTL_Calendar.getNextOpponent(calendarList[0], teamList[1]);
        Test.stopTest();
        System.assertEquals(true, resultOne != null && resultTwo != null, 'Next opponent not got');
    }
   }