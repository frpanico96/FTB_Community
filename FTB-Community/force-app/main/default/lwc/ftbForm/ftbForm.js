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
        const eventName = event.target.name === 'signUp' ? 'startregister' : 'startlogin';
        const obj = {};
        obj['username'] = this.username;
        obj['password'] = this.password;
        const customEvent = new CustomEvent(eventName,{detail: JSON.stringify(obj)});
        this.dispatchEvent(customEvent);

    }
}