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

}
