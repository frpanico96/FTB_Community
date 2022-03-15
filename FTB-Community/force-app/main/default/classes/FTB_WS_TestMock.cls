/**@frpanico 2022-03-15
 * FTB
 * Global Mock class
 * To make test class
 * for callouts
 */

@isTest
global with sharing class FTB_WS_TestMock
{
    global static void setMock(Type mockClass)
    {
        Test.setMock(HttpCalloutMock.class, mockClass.newInstance());
    }
}
