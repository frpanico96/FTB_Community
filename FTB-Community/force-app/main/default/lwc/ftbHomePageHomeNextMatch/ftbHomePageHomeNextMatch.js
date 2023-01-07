/**@frpanico
 * Child component that shows the nextOpponent
 * It is composed of two boxes with an offset in height and lenght
 * @/VS
 *     NextOpponent
 */
import { LightningElement, api, track } from 'lwc';

export default class FtbHomePageHomeNextMatch extends LightningElement 
{
  @api nextMatchPayload = {};

  get homeAway()
  {
    return this.nextMatchPayload?.homeAway ? this.nextMatchPayload.homeAway : 'VS';
  }

  get nextOpponent()
  {
    return this.nextMatchPayload?.nextOpponent ? this.nextMatchPayload.nextOpponent : 'Opponent';
  }
}