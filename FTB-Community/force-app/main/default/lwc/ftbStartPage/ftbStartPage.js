/**@frpanico 2022-02-06
 * FTB
 * Start Page Component
 */
import { api, track } from 'lwc';
import FtbUtils from 'c/ftbUtils';

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
    @track spinnerVisible;

    /* Need to implement promise to make the call be effective*/
    connectedCallback()
    {
        /* No logic needed for headerVisible and buttonVisible */
        this.headerVisible = true;
        this.buttonVisible = true;
        this.spinnerVisible = true;

        let componentName = this.getComponentName('c-ftb-start-page');
        console.log('#Component Name >>> ' + componentName);
        this.getConfigurationMessage(componentName)
        .then(result => 
            {
                console.log('#FtbStartPage Result >>>' + JSON.stringify(result));
                console.log('#StartPage_HeaderMessage >>> ' + result.header.message);
                console.log('#StartPage_HeaderPosition >>> ' + result.header.position);
                console.log('#StartPage_HeaderTextStyle >>> ' + result.header.textStyle);
                console.log('#StartPage_HeaderAdditionStyling >>> ' + this.additionalStyling);
                console.log('#StartPage_TileMessage >>> ' + result.tile.message);
                console.log('#StartPage_TileButtone >>> ' + result.tile.button);
                console.log('#StartPage_TileSpinner >>> ' + result.tile.spinner);
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

}