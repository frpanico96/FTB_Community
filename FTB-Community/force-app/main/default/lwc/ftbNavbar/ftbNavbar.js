/**@frpanico
 * Generic NavBar component
 */
import { LightningElement, track, api } from 'lwc';

export default class FtbNavbar extends LightningElement 
{
  @api navItems;

  btnClick(event)
  {
    event.preventDefault();
    const btnEvent = new CustomEvent('btnclick', {detail: event.target.name});
    this.dispatchEvent(btnEvent);
  }

}