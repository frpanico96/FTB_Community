/**@frpanico
 * Generic data table component
 */
import { LightningElement, track, api } from 'lwc';

export default class FtbDataTable extends LightningElement 
{
  @api tableData = [];
  @api tableColumns = [];
  @api tableHeader;

  connectedCallback()
  {
    console.log('TableData >>> ' + JSON.stringify(this.tableData));
    console.log('TableColumns >>> ' + JSON.stringify(this.tableColumns));
  }
}