/**@frpanico
 * Generic accordion component
 * #### This component is not used at the time #### 
 */
import { LightningElement, track, api } from 'lwc';

export default class FtbAccordion extends LightningElement 
{
  @api accordionItems = 
  [
    {
      id: 1,
      teamName: 'Team Test 1',
      header: 
      [
       {
        label: 'Role',
        fieldName: 'role',
        hideLabel: true
       },
       {
        label: 'Full Name',
        fieldName: 'fullname',
        hideLabel: true
       },
       {
        label: 'Points (Avg)',
        fieldName: 'avgpoints',
        hideLabel: true
       }
      ],
      dataObj:
      [
        {
          id: '1',
          role: 'G',
          fullname: 'test1',
          avgpoints: 32
        },
        {
          id: '2',
          role: 'C',
          fullname: 'test2',
          avgpoints: 25
        },
        {
          id: '3',
          role: 'F',
          fullname: 'test3',
          avgpoints: 28
        }
      ]
    },
    {
      id: 2,
      teamName: 'Team Test 2',
      header: 
      [
       {
        label: 'Role',
        fieldName: 'role',
        hideLabel: true
       },
       {
        label: 'Full Name',
        fieldName: 'fullname',
        hideLabel: true
       },
       {
        label: 'Points (Avg)',
        fieldName: 'avgpoints',
        hideLabel: true
       }
      ],
      dataObj:
      [
        {
          id: '4',
          role: 'G',
          fullname: 'test4',
          avgpoints: 19
        },
        {
          id: '5',
          role: 'C',
          fullname: 'test5',
          avgpoints: 10
        },
        {
          id: '6',
          role: 'F',
          fullname: 'test6',
          avgpoints: 31
        }
      ]
    }
  ];

}