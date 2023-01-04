/**@frpanico 2023-01-04
 * Utility Class for the Calendar Custom Object
 */
public with sharing class FTB_UTL_Calendar extends FTB_UTL_Utils
{
    private static final String HOME_SIGN = 'VS';
    private static final String AWAY_SIGN = '@';


    public static FTB_WRP_Utils.HomePageHomeCalendar getNextOpponent(FTB_Calendar__c calendar, FTB_Team__c singleTeam)
    {
        FTB_WRP_Utils.HomePageHomeCalendar result = new FTB_WRP_Utils.HomePageHomeCalendar();
        if(singleTeam.FTB_Championship__c == calendar.FTB_Championship__c)
        {
            result.championshipId = singleTeam.FTB_Championship__c;
            for(FTB_WRP_Utils.CalendarObj calendarObj : getPairings(calendar))
            {
                if(calendarObj.homeId.equalsIgnoreCase(singleTeam.Id))
                {
                    result.homeAway = 'VS';
                    result.nextOpponent = calendarObj.away;       
                }
                else if(calendarObj.awayId.equalsIgnoreCase(singleTeam.Id))
                {
                    result.homeAway = '@';
                    result.nextOpponent = calendarObj.home;       
                }
            }       
        }
        return result;
    }
    /* To be completed */
    private static List<FTB_WRP_Utils.CalendarObj> getUserTeamsPairings(List<FTB_Team__c> teamList, FTB_Calendar__c calendar)
    {
        List<FTB_WRP_Utils.CalendarObj> result = new List<FTB_WRP_Utils.CalendarObj>(); 
        Set<String> teamsId = FTB_UTL_Team.getSetIdFromList(teamList);
        return result;
    }
    private static List<FTB_WRP_Utils.CalendarObj> getPairings(FTB_Calendar__c calendar)
    {
        List<FTB_WRP_Utils.CalendarObj> result = new List<FTB_WRP_Utils.CalendarObj>();
        if(String.isNotBlank(calendar?.FTB_Pairings__c))
        {
            result = (List<FTB_WRP_Utils.CalendarObj>) JSON.deserialize(calendar?.FTB_Pairings__c, List<FTB_WRP_Utils.CalendarObj>.class);
        }
        return result;
    } 
    
}
