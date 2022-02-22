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
    /* Configuration Header */
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
    /* Configuration Tile */
    public class ConfigurationTile
    {
        /* Member Variables */
        public String message;
        public String button;
        public String spinner;
        /* Constructor */
        public ConfigurationTile()
        {
            this.message = '';
            this.button = '';
            this.spinner = '';
        }
    }
    /* Generic Wrapper for ftbStartPage */
    public class StartPageWrp
    {
        /* Member Variables */
        public Boolean check;
        public String message;
        /* Constructor */
        public StartPageWrp()
        {
            this.check = false;
            this.message = '';
        }
    }
}
