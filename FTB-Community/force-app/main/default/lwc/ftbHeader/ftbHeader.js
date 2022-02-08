/**@frapnico 2022-02-06
 * FTB
 * Generic Header for Components
 * Message is retrieved from Custom Metadata
 */
import { LightningElement, api, track} from 'lwc';


export default class FtbHeader extends LightningElement {
    
    @api headerMessage = '';
    @api position = '';
    @api textStyle = '';
    @api additionalStyling = '';

    @track className = '';

    connectedCallback()
    {
        console.log('# Header Connected #');
    }
    renderedCallback()
    {
        if(this.className == '')
        {
            console.log('#ftbHeader position >>> ' +this.position);
            console.log('#ftbHeader textStyle >>> ' +this.textStyle);
            console.log('#ftbHeader additionalStyling >>> ' +this.additionalStyling);
            if(this.position !== '')
            {
                this.className += this.position;
            }
            if(this.textStyle !== '')
            {
                this.className += ' ' + this.textStyle;
            }
            if(this.additionalStyling !== '')
            {
                this.className += ' ' + this.additionalStyling;
            }
        }
        
    }

}