/**@frpanico
 * Generic form component
 * When the Sign In/Sign Up button is clicked it dispatches a custom event
 */
import { LightningElement, track, api } from 'lwc';

export default class FtbForm extends LightningElement
{
    @track username;
    @track password;

    handleChange = event => 
    {
        let value = event.detail.value
        if(event.target.name === 'username')
        {
            this.username = value;
        }
        else
        {
            this.password = value;
        }
    }

    handleClick = event =>
    {
        event.preventDefault();

        console.log('### Event clicked ' + event.target.name);

        const eventName = 'sign';
        const obj = {};
        obj['username'] = this.username;
        obj['password'] = this.password;
        obj['signtype'] = event.target.name;
        const customEvent = new CustomEvent(eventName,{detail: JSON.stringify(obj)});
        this.dispatchEvent(customEvent);

    }
}