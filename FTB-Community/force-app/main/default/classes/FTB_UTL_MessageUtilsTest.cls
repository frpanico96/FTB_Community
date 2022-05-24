/**@frpanico 2022-03-15
 * FTB
 * FTB_UTL_MessageUtils
 * Test class
 */
@isTest
public with sharing class FTB_UTL_MessageUtilsTest 
{
    @isTest
    static void messageTest()
    {
        FTB_UTL_MessageUtils messageUtl = new FTB_UTL_MessageUtils();
        System.assertEquals(true, String.isNotBlank(messageUtl.existingPlayerMessage), 'Message failed');
    }
}
