/**@frpanico 2022-02-06
 * FTB
 * Tile Component
 */
import { LightningElement, api, track } from 'lwc';

export default class FtbTile extends LightningElement {

    @api messageConfiguration;
    @api buttonConfiguration;
    @api spinnerConfiguration;
    @api headerVisible;
    @api buttonVisible;
    @api spinnerVisible;

    @track firstMessage = '';
    @track secondMessage = '';
    @track firstMessageStyle = '';
    @track secondMessageStyle = '';
    @track buttonStyle = '';
    @track buttonLabel = '';
    @track buttonName = '';
    @track buttonDisabled = '';
    @track spinnerMessage = '';
    @track spinnerText = '';
    @track spinnerSize = '';
    @track spinnerVariant = '';
    @track spinnerMessage = '';
    @track spinnerMessageStyle = '';


    buttonClick(event)
    {
        event.preventDefault();
        const buttonClickEvent = new CustomEvent('buttonclick',{detail:'button clicked'});
        this.dispatchEvent(buttonClickEvent);
    }

}