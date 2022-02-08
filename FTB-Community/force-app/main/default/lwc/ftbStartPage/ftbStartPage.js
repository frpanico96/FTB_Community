/**@frpanico 2022-02-06
 * FTB
 * Start Page Component
 */
import { api, track } from 'lwc';
import FtbUtils from 'c/ftbUtils';

export default class FtbStartPage extends FtbUtils {

    @track headerMessage = '';
    @track headerPosition = 'slds-align_absolute-center';
    @track headerTextStyle = 'slds-text-heading_large slds-text-font_monospace'

    /* Need to implement promise to make the call be effective*/
    connectedCallback()
    {
        let componentName = this.getComponentName('c-ftb-start-page');
        console.log('#Component Name >>> ' + componentName);
        this.getConfigurationMessage(componentName)
        .then(result => 
            {
                this.headerMessage = result;
                console.log('#HeaderMessage >>> ' + this.headerMessage);
            }
        )
        .catch(error => 
        {
            this.showMessage('Error',JSON.stringify(error),'error');
        })
    }

}