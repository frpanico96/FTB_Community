/**@frpanico
 * Test class for FTB_WS_Utils
 */
@isTest
public with sharing class FTB_WS_UtilsTest
{
    @isTest
    static void makeCalloutTest()
    {
        FTB_WS_Utils testClass = new FTB_WS_Utils('test', 'POST', 1200, 'test');
        FTB_WS_TestMock.setMock(FTB_WS_IntegrationTest.TestMock.class);
        Test.startTest();
            HttpResponse result = testClass.makeCallout();
        Test.stopTest();
        System.assertEquals(true, String.isNotBlank(result.getBody()), 'Callout not executed');
    }
}