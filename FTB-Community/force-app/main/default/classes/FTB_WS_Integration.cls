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
    private FTB_QR_Utils qrUtils = new FTB_QR_Utils();

    public FTB_WS_Integration(FTB_ENM_Service service)
    {
        this.service = service;
    }
    /* The execute method is the core method
    * it creates the body
    * calls the service
    * handles the response
    * It returns a Map<String,String> with all the details of the integrations
    * TBD: keys
    */
    public FTB_WRP_OperationResult execute()
    {
        /* Method variable */
        String bodyResponse = '';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        /* Instance the interface
        * and collect the endpoint
        */
        Map<String,String> integrationMap = getIntegrationInfos(this.service);
        
        if(integrationMap.get('ERROR_CODE') != null)
        {
            return new FTB_WRP_OperationResult(integrationMap.get('ERROR_CODE'),integrationMap.get('ERROR_DESCRIPTION'));
        }
        
        FTB_INF_FetchData dataFetcher = (FTB_INF_FetchData)Type.forName(integrationMap.get('classname')).newInstance();

        /* Start service callout */
        try
        {
            request.setEndpoint(dataFetcher.setEndpoint(integrationMap.get('endpoint')));
            request.setHeader('Content-Type', 'application/json');
            request.setMethod(integrationMap.get('method'));
            request.setTimeout(12000);

            response = http.send(request);
        }
        catch(Exception e)
        {
            System.debug('Error: ' + e.getMessage() + '. At line: ' + e.getLineNumber() + '. The error occured during the service callout: ' + this.service);
            bodyResponse = 'INTEGRATION_ERROR';
            response = null;
            return new FTB_WRP_OperationResult('INT-0002',bodyResponse);
        }

        return dataFetcher.handleResponse(response.getBody());

    }
    /* getIntegrationInfos converts the enum in a className
    * and gets the endpoint
    * based on the service
    * with the help of the custom metadata
    * FTB_IntegrationConfiguration__mdt
    */
    private Map<String,String> getIntegrationInfos(FTB_ENM_Service service)
    {
        Map<String,String> integrationMap = new Map<String,String>();
        List<FTB_CMT_IntegrationConfiguration__mdt> integrationConfigurations = qrUtils.getIntegrationConfiguration(String.valueOf(service));
        for(FTB_CMT_IntegrationConfiguration__mdt integrationConfiguration : integrationConfigurations)
        {
            if(FTB_ENM_Service.valueOf(integrationConfiguration.FTB_EnumService__c) == service)
            {
                integrationMap.put('classname',integrationConfiguration.FTB_ClassName__c);
                integrationMap.put('endpoint', integrationConfiguration.FTB_Endpoint__c);
                integrationMap.put('method', integrationConfiguration.FTB_Method__c);
                break;
            }
        }
        if(integrationMap.isEmpty())
        {
            integrationMap.put('ERROR_DESCRIPTION','Could not fetch integration configurations');
            integrationMap.put('ERROR_CODE','INT-0001');
        }
        return integrationMap;
    }

}
