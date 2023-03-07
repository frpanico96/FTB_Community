import { LightningElement, api, track } from 'lwc';

import FtbUtils from 'c/ftbUtils';

export default class FtbBoxTeam extends FtbUtils 
{
  @track starterObj =
  [
    {
      id: 1,
      opts:     
      [
        {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
      ],
    },
    {
      id: 2,
      opts:     
      [
        {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
      ],
    },
    {
      id: 3,
      opts:     
      [
        {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
      ],
    },
    {
      id: 4,
      opts:     
      [
        {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
      ],
    },
    {
      id: 5,
      opts:     
      [
        {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
      ],
    },
  ];
  @track sixth =
  [
    {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
    {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
    {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
    {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
    {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
  ]
  @track benchObj =
  [
    {
      id: 1,
      opts:     
      [
        {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
      ],
    },
    {
      id: 2,
      opts:     
      [
        {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
      ],
    },
    {
      id: 3,
      opts:     
      [
        {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
      ],
    },
    {
      id: 4,
      opts:     
      [
        {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
      ],
    }, 
  ]
  @track offteamObj =
  [
    {
      id: 1,
      opts:     
      [
        {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
      ],
    },
    {
      id: 2,
      opts:     
      [
        {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
      ],
    },
    {
      id: 3,
      opts:     
      [
        {label: 'Player Name 1: 32', value: 'playerValue1', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 2: 12', value: 'playerValue2', role: 'G', status: 'normal', iscpt: false},
        {label: 'Player Name 3: 23', value: 'playerValue3', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 4: 14', value: 'playerValue4', role: 'F', status: 'normal', iscpt: false},
        {label: 'Player Name 5: 10', value: 'playerValue5', role: 'C', status: 'normal', iscpt: false},
      ],
    },
  ]
}