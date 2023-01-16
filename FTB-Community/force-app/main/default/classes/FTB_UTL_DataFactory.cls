/**@frpanico 2022-03-06
 * FTB
 * Factory Class to create test data
 */
public with sharing class FTB_UTL_DataFactory
{
    public static List<FTB_Player__c> createPlayers(Boolean create, Integer numberOfRecords)
    {
        List<FTB_Player__c> players = new List<FTB_Player__c>();
        for(Integer i = 0; i < numberOfRecords; ++i)
        {   
            FTB_Player__c player = new FTB_Player__c();
            player.Name = 'Player ' + i;
            player.FTB_IsActive__c = true;
            players.add(player);
        }
        if(!players.isEmpty() && create)
        {
            insert players;
        }
        return players;
    }
    public static List<FTB_Championship__c> createChampionships(Boolean create, Integer numberOfRecords)
    {
        List<FTB_Championship__c> championships = new List<FTB_Championship__c>();
        for(Integer i=0; i< numberOfRecords; ++i)
        {
            FTB_Championship__c championship = new FTB_Championship__c();
            championship.FTB_StartDate__c = System.today();
            championship.FTB_EndDate__c = System.today().addDays(i+1);
            championship.FTB_TotalRounds__c = 10;
            championships.add(championship);
        }
        if(!championships.isEmpty() && create)
        {
            insert championships;
        }
        return championships;
    }
    public static List<FTB_User__c> createUser(Boolean create, Integer numberOfRecords)
    {
        List<FTB_User__c> userList = new List<FTB_User__c>();
        for(Integer i=0; i< numberOfRecords; ++i)
        {
            FTB_User__c singleUser = new FTB_User__c();
            singleUser.FTB_Role__c = 'Player';
            singleUser.FTB_Username__c = 'username '+i;
            userList.add(singleUser);
        }
        if(!userList.isEmpty() && create)
        {
            insert userList;
        }
        return userList;
    }
    public static List<FTB_Session__c> createSession(Boolean create, Integer numberOfRecords, String userId)
    {
        List<FTB_Session__c> sessionList = new List<FTB_Session__c>();
        for(Integer i=0; i< numberOfRecords; ++i)
        {
            FTB_Session__c singleSession = new FTB_Session__c();
            singleSession.FTB_SessionId__c = 'testSession'+i;
            singleSession.FTB_User__c = userId;
            sessionList.add(singleSession);
        }
        if(!sessionList.isEmpty() && create)
        {
            insert sessionList;
        }
        return sessionList;
    }
    public static List<FTB_Team__c> createTeam(Boolean create, Integer numberOfRecords, String championshipId)
    {
        List<FTB_Team__c> teamList = new List<FTB_Team__c>();
        for(Integer i=0; i< numberOfRecords; ++i)
        {
            FTB_Team__c team = new FTB_Team__c();
            team.FTB_Championship__c = championshipId;
            team.FTB_ShortName__c = 't'+i;
            team.FTB_Win__c = 5;
            team.FTB_Loss__c = 1;
            teamList.add(team);
        }
        if(!teamList.isEmpty() && create)
        {
            insert teamList;
        }
        return teamList;
    }
    public static List<FTB_Calendar__c> createCalendar(Boolean create, Integer numberOfRecords, String championshipId)
    {
        List<FTB_Calendar__c> calendarList = new List<FTB_Calendar__c>();
        for(Integer i = 0; i < numberOfRecords; ++i)
        {
            FTB_Calendar__c calendar = new FTB_Calendar__c();
            calendar.FTB_Championship__c = championshipId;
            calendarList.add(calendar);
        }
        if(!calendarList.isEmpty() && create)
        {
            insert calendarList;
        }
        return calendarList;
    }
    public static List<FTB_Queue__c> createQueue(Boolean create, Integer numberOfRecords)
    {
        List<FTB_Queue__c> queueList = new List<FTB_Queue__c>();
        for(Integer i = 0; i < numberOfRecords; ++i)
        {
            FTB_Queue__c singleQueue = new FTB_Queue__c();
            singleQueue.FTB_Payload__c = JSON.serialize(new Map<String, String>{'test' => 'test'});
            queueList.add(singleQueue);
        }
        if(!queueList.isEmpty() && create)
        {
            insert queueList;
        }
        return queueList;
    }
}
