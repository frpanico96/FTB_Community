/**@frpanico 2022-02-06
 * FTB
 * Tile Component
 */
import { ingestDataConnector } from 'lightning/analyticsWaveApi';
import { LightningElement, api, track } from 'lwc';

export default class FtbTile extends LightningElement {
    /* @api variables */
    @api messageConfiguration;
    @api buttonConfiguration;
    @api spinnerConfiguration;
    @api headerVisible;
    @api buttonVisible;
    @api buttonDisabled;
    @api buttonMessage;
    @api spinnerVisible;
    /* @track variables */
    @track firstMessage = '';
    @track secondMessage = '';
    @track firstMessageStyle = '';
    @track secondMessageStyle = '';
    @track messageConfigured = false;
    @track buttonStyle = '';
    @track buttonLabel = '';
    @track buttonName = '';
    @track buttonVariant = '';
    @track buttonConfigured = false;
    @track spinnerVisible = '';
    @track spinnerText = '';
    @track spinnerSize = '';
    @track spinnerVariant = '';
    @track spinnerMessage = '';
    @track spinnerMessageStyle = '';
    @track spinnerConfigured = false;
    /* Fire a custom event when the button is clicked */
    buttonClick(event)
    {
        event.preventDefault();
        const buttonClickEvent = new CustomEvent('buttonclick',{detail:'button clicked'});
        this.dispatchEvent(buttonClickEvent);
    }
    /* Log the connection of the component */
    connectedCallback()
    {
        console.log('# Tile Connected #');
    }
    /* Render Tile properties */
    renderedCallback()
    {
        console.log('# Tile Rendering #');
        if(this.messageConfigured === false && this.messageConfiguration !== '')
        {
            console.log('#Tile_MessageConfiguration >>> ' + this.messageConfiguration);
            let messageObj = JSON.parse(this.messageConfiguration);
            this.firstMessage = messageObj["firstMessage"];
            this.secondMessage = messageObj["secondMessage"];
            this.firstMessageStyle = messageObj["firstMessageStyle"];
            this.secondMessageStyle = messageObj["secondMessageStyle"];
            this.messageConfigured = true;
        }
        if(this.buttonConfigured === false && this.buttonConfiguration !== '')
        {
            
            let buttonObj = JSON.parse(this.buttonConfiguration);
            console.log('#Tile_ButtonConfiguration >>> ' + buttonObj);
            this.buttonStyle = buttonObj["buttonStyle"];
            this.buttonLabel = buttonObj["buttonLabel"];
            this.buttonName = buttonObj["buttonName"];
            this.buttonVariant = buttonObj["buttonVariant"];
            this.buttonConfigured = true;
        }
        if(this.spinnerConfigured === false && this.spinnerConfiguration !== '')
        {
            console.log('#Tile_SpinnerConfiguration >>> ' + this.spinnerConfiguration);
            let spinnerObj = JSON.parse(this.spinnerConfiguration);
            this.spinnerText = spinnerObj["spinnerText"];
            this.spinnerSize = spinnerObj["spinnerSize"];
            this.spinnerVariant = spinnerObj["spinnerVariant"];
            this.spinnerMessage = spinnerObj["spinnerMessage"];
            this.spinnerMessageStyle = spinnerObj["spinnerMessageStyle"];
            this.spinnerConfigured = true;
        }
    }
}