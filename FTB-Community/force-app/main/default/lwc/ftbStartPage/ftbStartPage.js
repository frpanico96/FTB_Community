/**@frpanico 2022-02-06
 * FTB
 * Start Page Component
 */
import { LightningElement } from 'lwc';
import FtbUtils from 'c/ftbUtils';

export default class FtbStartPage extends FtbUtils {

    connectedCallback()
    {
        let componentName = this.getComponentName('c-ftb-start-page');
        //console.log('#Component Name >>> ' + componentName);
    }

}