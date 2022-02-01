import { LightningElement, api, track } from 'lwc';

export default class FtbLogin extends LightningElement 
{
    /* @api fields */
    /* @track fields */
    @track loginMessage;

    /* connected callback */
    connectedCallback()
    {
        /* get login message from configuration
        * 01/02/2022 mock
        */
       this.loginMessage = 'FTB - La prima community di Fantabasket italiana';
    }
}