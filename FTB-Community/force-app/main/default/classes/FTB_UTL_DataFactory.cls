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
        if(!players.isEmpty())
        {
            insert players;
        }
        return players;
    }
}
