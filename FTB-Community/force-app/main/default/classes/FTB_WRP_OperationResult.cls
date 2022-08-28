/**@frpanico 2022-03-12
 * FTB
 * Wrapper for result
 * it contains three properties
 * ERROR_CODE
 * ERROR_DESCRIPTION
 * SUCCESS
 * ERROR_MESSAGE
 * A method isSuccess()
 * which returns a boolean indicating success (true)
 * or failure (false)
 * of the operation
 * A method messageFormatter()
 * which formats the message
 */
public with sharing class FTB_WRP_OperationResult 
{
    
    public String ERROR_CODE {get;set;}
    public String ERROR_DESCRIPTION {get;set;}
    public Boolean SUCCESS{get;set;}
    public String ERROR_MESSAGE{get;set;}
    public String IDENTIFICATION_KEY{get; set;}

    public FTB_WRP_OperationResult(String errorCode, String errorDescription) 
    {
        this.ERROR_CODE = errorCode;
        this.ERROR_DESCRIPTION = errorDescription;
        this.SUCCESS = isSuccess();
        this.ERROR_MESSAGE = messageFormatter();
    }
    public FTB_WRP_OperationResult(String errorCode, String errorDescription, String identificationKey) 
    {
        this.ERROR_CODE = errorCode;
        this.ERROR_DESCRIPTION = errorDescription;
        this.SUCCESS = isSuccess();
        this.ERROR_MESSAGE = messageFormatter();
        this.IDENTIFICATION_KEY = identificationKey;
    }
    /* The method isSuccess
    * check wether the ERROR_CODE
    * contains the code 0000
    * which is by definition
    * the success operation code
    */
    private Boolean isSuccess()
    {
        return this.ERROR_CODE.indexOf('0000') > -1;
    }
    private String messageFormatter()
    {
        return '[' + this.ERROR_CODE + ']' + ' ' + this.ERROR_DESCRIPTION;
    }
}   
