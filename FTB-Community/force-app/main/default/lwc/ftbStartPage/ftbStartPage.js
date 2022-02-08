/**@frpanico 2022-02-06
 * FTB
 * Start Page Component
 */
import { api, track } from 'lwc';
import FtbUtils from 'c/ftbUtils';

export default class FtbStartPage extends FtbUtils {

    @track headerMessage = '';
    @track headerPosition = '';
    @track headerTextStyle = '';
    @track headerAdditionStyling = '';

    /* Need to implement promise to make the call be effective*/
    connectedCallback()
    {
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
                console.log('#HeaderMessage >>> ' + this.headerMessage);
                console.log('#HeaderPosition >>> ' + this.headerPosition);
                console.log('#HeaderTextStyle >>> ' + this.headerTextStyle);
                console.log('#HeaderAdditionStyling >>> ' + this.additionalStyling)
            }
        )
        .catch(error => 
        {
            this.showMessage('Error',JSON.stringify(error),'error');
        })
    }

}