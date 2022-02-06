/**@frpanico 2022-02-06
 * FTB
 * Utility Component
 */
import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

/* Server imports */
import getConfiguration from '@salesforce/apex/FTB_LCR_Utils.getConfiguration';

export default class FtbUtils extends LightningElement {

    /**@frpanico 2022-02-06
     * FTB
     * Method to get component name
     * format: ftbComponentName
     */
    @api
    getComponentName(componentName)
    {
        let returnName = '';
        componentName = componentName.split('-').slice(1);
        console.log('#Name >>>' + JSON.stringify(componentName));
        componentName.forEach(element => {returnName += element.charAt(0).toUpperCase() + element.slice(1)});
        console.log('#ReturnName >>> ' + returnName); 
    }
    /**@frpanico 2022-02-06
     * FTB
     * Method to get configured message
     */
    @api
    getConfigurationMessage(componentName)
    {
        getConfiguration({componentName: componentName})
        .then(data => 
            {
                if(data)
                {
                    return data.message
                }
            }
        )
        .catch(error => 
            {
                console.log('#getConfigurationMessage error >>> ' + JSON.stringify(error));
                this.showMessage('Error',JSON.stringify(error),'error');
            }
        );
    }
    /**@frpanico 2022-02-06
     * FTB
     * ShowMessage handler
     */
    @api
    showMessage(title,message,variant)
    {
        const event = new ShowToastEvent(
            {
                title: title,
                message: message,
                variant: variant,
            }
        )
    }


}