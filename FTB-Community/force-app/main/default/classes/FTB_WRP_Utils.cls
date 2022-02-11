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
        public ConfigurationTile tile;
        /* Constructor */
        public ConfigurationWrapper()
        {
            this.header = new ConfigurationHeader();
            this.tile = new ConfigurationTile();
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
    public class ConfigurationTile
    {
        public String message;
        public String button;
        public String spinner;
        public ConfigurationTile()
        {
            this.message = '';
            this.button = '';
            this.spinner = '';
        }
    }
    

}
