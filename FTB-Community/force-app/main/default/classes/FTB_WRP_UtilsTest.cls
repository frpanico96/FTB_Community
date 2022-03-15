/**@frpanico 2022-03-15
 * FTB
 * FTB_WRP_Utils
 * Test class
 */
@isTest
public with sharing class FTB_WRP_UtilsTest 
{
    @isTest
    static void test()
    {
        FTB_WRP_Utils.ConfigurationWrapper confWrapper = new FTB_WRP_Utils.ConfigurationWrapper();
        FTB_WRP_Utils.StartPageWrp startPageWrp = new  FTB_WRP_Utils.StartPageWrp();

        System.assertEquals('', confWrapper.header.message, 'Configuration Wrapper not created');
        System.assertEquals('', confWrapper.tile.message, 'Configuration Wrapper not created');
        System.assertEquals(false, startPageWrp.check, 'StartPage Wrapper not created');
    }
}
