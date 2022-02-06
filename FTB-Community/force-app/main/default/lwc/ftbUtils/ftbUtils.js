/**@frpanico 2022-02-06
 * FTB
 * Utility Component
 */
import { LightningElement, api } from 'lwc';

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


}