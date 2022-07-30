/**@frpanico 2022-06-23
 * Controller class
 * for the ftbLogin component
 */
public with sharing class FTB_LC_Login extends FTB_UTL_Utils
{
    private static FTB_UTL_Utils ftbUtils = new FTB_UTL_Utils();

    private static String ERROR_MESSAGE = 'Unable to Login. Please contact the administrator.';
    private static String SUCCESS_CODE = 'LOG-0000';
    private static String ERROR_LOGIN_CODE = 'LOG-0001';
    private static String ERROR_REGISTRATION_CODE = 'LOG-0002';
    private static String ERROR_LOGIN_MESSAGE = 'User not found. If you are already registered check your username and password are correct. Otherwise if your are not yet register click the Sign On button';
    private static String ERROR_REGISTRATION_MESSAGE = 'User already registered';
    /* Api method called from client */
    @AuraEnabled
    public static String makeLogin(String credentials){
        try 
        {
            return makeLoginOperations(credentials);
        } 
        catch (Exception e) 
        {
            System.debug(LoggingLevel.DEBUG, e.getMessage() + ' At line ' + e.getLineNumber());
            throw new AuraHandledException(ERROR_MESSAGE);
        }
    }
    @AuraEnabled
    public static string makeRegister(String credentials){
        try {
            return makeRegisterOperations(credentials);            
        } catch (Exception e) {
            System.debug(LoggingLevel.DEBUG, e.getMessage() + ' At line ' + e.getLineNumber());
            throw new AuraHandledException(ERROR_MESSAGE);
        }
    }
    /** Perform Login Operations
     * Search for user
     * If user is found password is checked
     * If password matches session is created
     * and returned to the component
     */
    private static String makeLoginOperations(String credentials)
    {
        Map<String, String> credentialsMap = (Map<String,String>) JSON.deserialize(credentials, Map<String,String>.class);
        String username = credentialsMap.get('username');
        return '';
    }
    /* This method uses Crypto class to generate session Id */

    private static String makeRegisterOperations(String credentials)
    {
        Map<String, String> credentialsMap = (Map<String,String>) JSON.deserialize(credentials, Map<String,String>.class);
        String username = credentialsMap.get('username');
        FTB_Queue__c que = new FTB_Queue__c();

        que.FTB_Payload__c = credentials;
        que.FTB_Operation__c = String.valueOf(FTB_ENM_Service.SIGN);

        ftbUtils.insertSObject(que);

        return que.Id;

    }
}
