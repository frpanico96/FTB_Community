/**@frpanico 2022-03-15
 * FTB
 * FTB_WRP_OperationResult
 * Test class
 */
@isTest
public with sharing class FTB_WRP_OperationResultTest 
{
    @isTest
    static void test()
    {
        FTB_WRP_OperationResult opResult = new FTB_WRP_OperationResult('TEST-0000','SUCCESS');
        System.assertEquals(true, opResult.SUCCESS, 'Operation Result Wrapper success error');
        System.assertEquals('[TEST-0000] SUCCESS', opResult.ERROR_MESSAGE,'Operation Result Wrapper message error');
        
    }
}
