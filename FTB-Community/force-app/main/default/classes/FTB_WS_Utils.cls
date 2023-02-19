/**@frpanico
 * This class operates in addition to FTB_WS_Integration
 * Sometimes it is not possible to make straightforward callouts
 * It may be dismissed and be replaced by FTB_WS_Integration
 * UP: The class have been replace by FTB_WS_Integration
 */
public with sharing class FTB_WS_Utils
{
    public String endpoint;
    public String method;
    public Integer timeout;
    public String body;

    public FTB_WS_Utils(String endpoint, String method, Integer timeout, String body)
    {
        this.endpoint = endpoint;
        this.method = method;
        this.timeout = timeout;
        this.body = body;
    }

    public HttpResponse makeCallout()
    {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse result = new HttpResponse();

        try
        {
            req.setEndpoint(this.endpoint);
            //req.setHeader('Content-Type', 'application/json');
            req.setMethod(this.method);
            req.setBody(this.body);
            //req.setTimeout(this.timeout);

            result = http.send(req);
        }
        catch(Exception e)
        {
            result.setStatusCode(500);
            result.setBody(e.getMessage());
            result.setStatus('failed');
        }

        return result;
    }


}
