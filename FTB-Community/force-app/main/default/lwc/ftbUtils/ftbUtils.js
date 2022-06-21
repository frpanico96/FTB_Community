/**@frpanico 2022-02-06
 * FTB
 * Utility Component
 */
import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation'
/* Server imports */
import getConfiguration from '@salesforce/apex/FTB_LC_Utils.getConfiguration';

export default class FtbUtils extends NavigationMixin(LightningElement) {

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
        return returnName; 
    }
    /**@frpanico 2022-02-06
     * FTB
     * Method to get configured message
     */
    @api
    getConfigurationMessage(componentName)
    {
        return new Promise((resolve, reject) => {
        getConfiguration({componentName: componentName})
            .then(data => 
                {
                    let wrpObject = JSON.parse(data);
                    if(data)
                    {
                        console.log('#Data Message >>> ' + wrpObject);
                        resolve(wrpObject);
                    }
                }
            )
            .catch(error => 
                {
                    console.log('#getConfigurationMessage error >>> ' + JSON.stringify(error));
                    this.showMessage('Error',JSON.stringify(error),'error');
                    reject(error);
                }
            );
        });    
    }
    /**@frpanico 2022-02-06
     * FTB
     * ShowMessage handler
     */
    @api
    showMessage(title,message,variant,mode='dismissible')
    {
        console.log('event dispatching - START');
        const event = new ShowToastEvent(
            {
                title: title,
                message: message,
                variant: variant,
                mode: mode
            }
        )
        this.dispatchEvent(event);
        console.log('event dispatching - END');
    }
    /* Custom Navigation Method */
    @api
    handleNavigation(navigationObjSer)
    {
        console.log(navigationObjSer);
        let navigationObj = JSON.parse(navigationObjSer);
        this[NavigationMixin.Navigate](navigationObj);
    }


}