/**@frpanico 2022-05-26
 * Test class FTB_LC_StartPage
 */
@isTest
public with sharing class FTB_LC_StartPageTest 
{
    @TestSetup
    static void setup()
    {
        FTB_UTL_DataFactory.createPlayers(true, 1);    
    }
    @isTest
    static void checkExistingPlayerTest()
    {
        String result = '';
        Test.startTest();
            result = FTB_LC_StartPage.checkExistingPlayer();
        Test.stopTest();
        System.assertEquals(true, String.isNotBlank(result), 'check existing player failed');
    }
    @isTest
    static void createPlayerTest()
    {
        String service = 'GET_PLAYERS';
        String result = '';
        FTB_WS_TestMock.setMock(FTB_WS_IntegrationTest.TestMock.class);
        Test.startTest();
            result = FTB_LC_StartPage.createPlayers(service);
        Test.stopTest();
        System.assertEquals(true, String.isNotBlank(result), 'create player failed');
    }
    @isTest
    static void getListViewTest()
    {
        String objectName = 'FTB_Player__c';
        String developerNameBase = 'FTB';
        String result = '';
        Test.startTest();
            result = FTB_LC_StartPage.getListView(objectName, developerNameBase);
        Test.stopTest();
        System.assertEquals(true, String.isNotBlank(result), 'get list view failed');
    }
}
