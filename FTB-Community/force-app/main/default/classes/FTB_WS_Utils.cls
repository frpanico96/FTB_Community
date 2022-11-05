public with sharing class FTB_WS_Utils
{
    public String endpoint;
    public String method;
    public Integer timeout;
    public String body;

    public HttpResponse makeCallout()
    {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse result = new HttpResponse();

        try
        {
            req.setEndpoint(this.endpoint);
            req.setHeader('Content-Type', 'application/json');
            req.setMethod(this.method);
            req.setBody(this.body);
            req.setTimeout(this.timeout);

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
