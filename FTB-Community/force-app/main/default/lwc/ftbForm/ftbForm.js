import { LightningElement } from 'lwc';

export default class FtbForm extends LightningElement 
{
    handleClick = event =>
    {
        event.preventDefault();
        console.log('#FtbForm catched login#')
    }
}