/**@frpanico 2022-03-07
 * FTB
 * Integration Interface
 * With methods to submit and handle
 * requests
 */
public interface FTB_INF_FetchData 
{  
    /* setEndpoint set the endpoint for the request */
    String setEndpoint(String endpoint);
    /* createBody creates the request body
    * this method will probably not be used
    * since there are only GET requests
    * which does not need any body
    */
    String setBody();
    /* handleResponse handle the response */
    FTB_WRP_OperationResult handleResponse(String bodyResponse);
    /* Method that get eventually called
    * From the batch 
    * if asynchronous operation are needed
    */
    void operate(List<FTB_WRP_Scope> scope);

}
