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
        let obj = {};
        obj['username'] = this.username;
        obj['password'] = this.password;
        const customEvent = new CustomEvent('startlogin',{detail: JSON.stringify(obj)});
        this.dispatchEvent(customEvent);

    }
}