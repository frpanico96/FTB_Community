/**@frpanico 2022-05-26
 * FTB
 * FTB_QR_Utils
 * Test class
 */
@isTest
public with sharing class FTB_LCR_UtilsTest 
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
            result = FTB_LCR_Utils.getConfiguration(componentName);
        Test.stopTest();
        System.assertEquals(true, String.isNotBlank(result),'get configuration failed');
    }
}
