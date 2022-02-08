/**@frpanic 2022-02-06
 * FTB
 * Utils Wrapper
 */
public with sharing class FTB_WRP_Utils 
{
    /* Configuration Wrapper */
    public class ConfigurationWrapper
    {
        /* Member Variables */
        public ConfigurationHeader header;
        /* Constructor */
        public ConfigurationWrapper()
        {
            this.header = new ConfigurationHeader();
        }
    }
    public class ConfigurationHeader
    {
        /* Member Variables */
        public String message;
        public String position;
        public String textStyle;
        public String additionalStyling;
        /* Constructor */
        public ConfigurationHeader()
        {
            this.message = '';
            this.position = '';
            this.textStyle = '';
            this.additionalStyling = '';
        }
    }
    

}
