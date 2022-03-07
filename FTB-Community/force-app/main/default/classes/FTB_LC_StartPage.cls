/**@frpanico 2022-02-15
 * FTB
 * Controller Class
 * For
 * ftbStartPage
 */
public with sharing class FTB_LC_StartPage extends FTB_UTL_Utils
{
    /* Member Variables */
    private static FTB_UTL_MessageUtils messageUtils = new FTB_UTL_MessageUtils(); 

    /**@frpanico 2022-02-15
     * FTB
     * checkExistingPlayer
     * no input
     * return a serialized
     * FTB_WRP_Utils.StartPageWrp 
     */
    @AuraEnabled(cacheable=true)
    public static String checkExistingPlayer()
    {
        /* Look for existing player
         * If no player is returned
         * check = true
         */
        FTB_WRP_Utils.StartPageWrp startPageWrp = new FTB_WRP_Utils.StartPageWrp();
        if(!(FTB_QR_Players.getAllPlayers()).isEmpty())
        {
            startPageWrp.check = true;
            startPageWrp.message = messageUtils.existingPlayerMessage;
        }
        return JSON.serialize(startPageWrp);
    }
    /* Core Method
    * the method performs the callout
    * and creates the players
    */
    @AuraEnabled
    public static String createPlayers(String service)
    {
        FTB_WS_Integration integration = new FTB_WS_Integration(FTB_ENM_Service.valueOf(service));
        Map<String,String> integrationResult = integration.execute();
        return JSON.serialize(integrationResult);
    }

}
