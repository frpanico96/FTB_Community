/**@frpanico 2022-05-26
 * Test class for FTB_LC_Utils
 */
@isTest
public with sharing class FTB_LC_UtilsTest 
{
    @TestSetup
    static void setup()
    {
        
    }
    @isTest
    static void getConfigurationTest()
    {
        String componentName = 'FtbStartPage';
        String result = '';
        Test.startTest();
            result = FTB_LC_Utils.getConfiguration(componentName);
        Test.stopTest();
        System.assertEquals(true, String.isNotBlank(result),'get configuration failed');
    }
    @isTest
    static void handleCometdSubscriptionTest()
    {
        FTB_WS_TestMock.setMock(FTB_WS_IntegrationTest.CometdMock.class);
        Test.startTest();
            String result = FTB_LC_Utils.handleCometdSubscription();
        Test.stopTest();
        System.assertEquals(true, String.isNotBlank(result),'Subscription not succeded');
    }
    @isTest
    static void handleCometdSubscriptionErrorTest()
    {
        String result = '';    
        Test.startTest();
        try
        {
            result = FTB_LC_Utils.handleCometdSubscription();
        }
        catch(Exception e)
        {
            result = '';
        }
        Test.stopTest();
        System.assertEquals(true, String.isBlank(result),'Exception not handled');
    } 
}
