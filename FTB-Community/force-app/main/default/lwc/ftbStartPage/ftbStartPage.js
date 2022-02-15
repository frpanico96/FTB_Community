/**@frpanico 2022-02-06
 * FTB
 * Start Page Component
 */
import { api, track } from 'lwc';
/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';
/* Import Server-side */
import getAllPlayers from '@salesforce/apex/FTB_LC_StartPage.checkExistingPlayer';

export default class FtbStartPage extends FtbUtils {

    /* Header Variables */
    @track headerMessage = '';
    @track headerPosition = '';
    @track headerTextStyle = '';
    @track headerAdditionStyling = '';
    /* Tile Variables */
    @track messageConfiguration = '';
    @track buttonConfiguration = '';
    @track spinnerConfiguration = '';
    @track headerVisible;
    @track buttonVisible;
    @track buttonDisabled;
    @track buttonMessage;
    @track spinnerVisible;
    /* Instances all the child elements */
    connectedCallback()
    {
        /* No logic needed for headerVisible and buttonVisible */
        this.headerVisible = true;
        this.buttonVisible = true;
        this.spinnerVisible = false;
        /* Check if the button need to be enabled */
        getAllPlayers({})
        .then(data => 
            {
                console.log('#FtbStartPage_getAllPlayers >>> ' + data);
                let wrpObj = JSON.parse(data);
                this.buttonDisabled = wrpObj.check;
                this.buttonMessage = wrpObj.message;
            })
        .catch(error => 
            {
                console.log('#FtbStartPage_getAllPlayersError >>> ' + error);
                this.buttonDisabled = true;
                this.buttonMessage = 'Unable to fetch data. Refresh the current page, if the error does not solve contact the product owner';
            });
        let componentName = this.getComponentName('c-ftb-start-page');
        console.log('#Component Name >>> ' + componentName);
        this.getConfigurationMessage(componentName)
        .then(result => 
            {
                console.log('#FtbStartPage Result >>>' + JSON.stringify(result));
                this.headerMessage = result.header.message;
                this.headerPosition = result.header.position;
                this.headerTextStyle = result.header.textStyle;
                this.headerAdditionStyling = result.header.additionalStyling;
                this.messageConfiguration = result.tile.message;
                this.buttonConfiguration = result.tile.button;
                this.spinnerConfiguration = result.tile.spinner;
            }
        )
        .catch(error => 
        {
            this.showMessage('Error',JSON.stringify(error),'error');
        })
    }
    /* Button Click Event Handler
     * Make a server-side call
     * that fetch and create players
     */
    generatePlayers(event)
    {
        console.log('#FtbStartPage_generatePlayerStart >>> ' + event.detail);
        this.buttonDisabled = true;
        this.spinnerVisible = true;
    }
}