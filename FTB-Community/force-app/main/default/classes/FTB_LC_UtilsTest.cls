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
}
