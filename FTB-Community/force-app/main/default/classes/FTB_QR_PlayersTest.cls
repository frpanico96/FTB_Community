/**@frpanico 2022-05-25
 * Test class for FTB_QR_Players
 */
@isTest
public with sharing class FTB_QR_PlayersTest 
{
    @TestSetup
    static void setup()
    {
        List<FTB_Player__c> players = FTB_UTL_DataFactory.createPlayers(true, 1);    
    }
    @isTest
    static void getAllPlayersTest()
    {
        Test.startTest();
            List<FTB_Player__c> players = FTB_QR_Players.getAllPlayers();
        Test.stopTest();
        System.assertEquals(true, !players.isEmpty(), 'get all players failed');
    }
}
