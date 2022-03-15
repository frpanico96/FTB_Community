/**@frpanico 2022-03-15
 * FTB
 * FTB_WRP_Players
 * Test class
 */
@isTest
public with sharing class FTB_WRP_PlayersTest 
{
    @isTest
    static void test()
    {
        FTB_WRP_Players playerWrp = new FTB_WRP_Players();
        System.assert(playerWrp.league == null, 'Player Wrp Not created');
    }
}
