/**@frapnico 2022-02-06
 * FTB
 * Generic Header for Components
 * Message is retrieved from Custom Metadata
 */
import { LightningElement, api} from 'lwc';


export default class FtbHeader extends LightningElement {
    
    @api headerMessage;

}