/**@frpanico 2023-01-04
 * Utility class for the Team Custom Object
 */
public with sharing class FTB_UTL_Team extends FTB_UTL_Utils 
{
    public static Set<String> getSetIdFromList(List<FTB_Team__c> teamList)
    {
        Set<String> result = new Set<String>();
        for(FTB_Team__c team : teamList)
        {
            result.add(team.Id);
        }
        return result;
    }
}
