/**@frpanico 2022-06-07
 * FTB
 * Home Page Component
 */
import { LightningElement, api, track } from 'lwc';
/* Import Utils Component */
import FtbUtils from 'c/ftbUtils';
export default class FtbHomePage extends FtbUtils
{
  @track navObj =
  [
    {name: 'home', label: 'Home'},
    {name: 'teams', label: 'Teams'},
    {name: 'standings', label: 'Standings'},
    {name: 'trades', label: 'Trades'},
  ]
}