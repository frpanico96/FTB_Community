/**@frpanico 2022-03-07
 * FTB
 * Core class that handles all the services
 * Based on the service it instances different classes
 * with the help of FTB_INF_FetchData
 */
public with sharing class FTB_WS_Integration 
{
    /* Memeber variables */
    /* service represents the service to be called */
    private FTB_ENM_Service service;

    FTB_WS_Integration(FTB_ENM_Service service)
    {
        this.service = service;
    }
    /* The execute method is the core method
    * it creates the body
    * calls the service
    * handles the response
    */
    public void execute()
    {
        /* Instance the interface */

    }
    /* getClassName converts the enum in a className
    * based on the service
    * with the help of the custom metadata
    * FTB_IntegrationConfiguration__mdt
    */
    private String getClassName(FTB_ENM_Service service)
    {
        String className = '';
        List<FTB_IntegrationConfiguration__mdt> integrationConfigurations = FTB_IntegrationConfiguration__mdt.getAll().values();
    }

}
