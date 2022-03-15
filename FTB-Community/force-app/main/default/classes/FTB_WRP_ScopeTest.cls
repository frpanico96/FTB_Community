/**@frpanico 2022-03-15
 * FTB
 * FTB_WRP_Scope
 * Test class
 */
@isTest
public with sharing class FTB_WRP_ScopeTest 
{
    @isTest
    static void test()
    {
        FTB_WRP_Scope scope = new FTB_WRP_Scope();
        System.assert(scope.integrationObj == null,'Scope Wrapper not created');
    }
}
