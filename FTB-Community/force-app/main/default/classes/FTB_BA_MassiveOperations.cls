/**@frpanico
 * Batch class used for operations that required higher governor limits
 * It takes in input a List<> of scope (which represents a generic iterable) and a variable called service
 * Through the integration object metadata the class related to the service is retrieved
 * The class implements the FTB_INF_FetchData interface
 */
public with sharing class FTB_BA_MassiveOperations extends FTB_UTL_Utils implements Database.Batchable<FTB_WRP_Scope>{
    
    private List<FTB_WRP_Scope> integrationObjectList = new List<FTB_WRP_Scope>();
    private String service;
    private FTB_INF_FetchData classInstance;
    
    public FTB_BA_MassiveOperations(List<FTB_WRP_Scope> integrationObjectList, String service) 
    {
        this.integrationObjectList = integrationObjectList;
        this.service = service;
        List<FTB_CMT_IntegrationConfiguration__mdt> integrationConfigurations = readSObject([SELECT 
        Id, 
        FTB_ClassName__c 
        FROM 
        FTB_CMT_IntegrationConfiguration__mdt 
        WHERE FTB_EnumService__c = :service]);
        if(!integrationConfigurations.isEmpty())
        {
            this.classInstance = (FTB_INF_FetchData)Type.forName(integrationConfigurations[0].FTB_ClassName__c).newInstance();
        }
    }

    public Iterable<FTB_WRP_Scope> start(Database.BatchableContext BC)
    {
        return this.integrationObjectList;
    }
    /** During the execute
     * The batch calls the method exposed by the class (implementing the interface)
     * called "operate"
     */
    public void execute(Database.BatchableContext BC, List<FTB_WRP_Scope> scope)
    {
        this.classInstance.operate(scope);
    }
    /* When the Job Finished a platform event is fired
    * to notificate the success
    */
    public void finish(Database.BatchableContext BC)
    {
        List<AsyncApexJob> jobs = readSObject([SELECT Id, 
        Status, 
        NumberOfErrors, 
        JobItemsProcessed, 
        TotalJobItems, 
        Createdby.Email, 
        ExtendedStatus
        FROM AsyncApexJob
        WHERE Id = :BC.getJobId()]);

        AsyncApexJob job = jobs[0];

        String message = 'Status: ' + job.Status + ' Errors: ' + job.NumberOfErrors + ' Job Run: ' + job.JobItemsProcessed;

        FTB_WRP_OperationResult opResult = new FTB_WRP_OperationResult('PLR-0000', message);
        
        FTB_PEV_NotificationMessage__e notification = new FTB_PEV_NotificationMessage__e();
        notification.FTB_SerializedMessage__c = JSON.serialize(opResult);
        notification.FTB_Service__c = this.service;

        Eventbus.publish(notification);

    }

}
