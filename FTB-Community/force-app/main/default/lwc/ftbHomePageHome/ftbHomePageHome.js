import { LightningElement, api, track } from 'lwc';

export default class FtbHomePageHome extends LightningElement 
{
  @track championshipTable = 
  [
    {id: '1', rank: '1', teamName: 'Team 1', win: '9', loss: '1'},
    {id: '2', rank: '2', teamName: 'Team 2', win: '8', loss: '2'},
    {id: '3', rank: '3', teamName: 'Team 3', win: '7', loss: '3'},
    {id: '4', rank: '4', teamName: 'Team 4', win: '6', loss: '4'},
    {id: '5', rank: '5', teamName: 'Team 5', win: '5', loss: '5'},
  ];
  @track championshipColumn = 
  [
    {label:'Rank', fieldName:'rank'},
    {label:'Team Name', fieldName:'teamName'},
    {label:'W', fieldName:'win'},
    {label:'L', fieldName:'loss'},
  ];
  @track championshipName = 'Championship #1'
  @track teamTable=
  [
    {
      id: 1,
      teamName:'Team 1',
      _children:
      [
        {
          role: 'G',
          playerName: 'Player 1-1',
          points: '25'
        },
        {
          role: 'G',
          playerName: 'Player 1-2',
          points: '18'
        },
        {
          role: 'F',
          playerName: 'Player 1-3',
          points: '23'
        },
        {
          role: 'F',
          playerName: 'Player 1-4',
          points: '20'
        },
        {
          role: 'C',
          playerName: 'Player 1-5',
          points: '29'
        }
      ]
    },
    {
      id: 2,
      teamName:'Team 2',
      _children:
      [
        {
          role: 'G',
          playerName: 'Player 2-1',
          points: '20'
        },
        {
          role: 'G',
          playerName: 'Player 2-2',
          points: '15'
        },
        {
          role: 'F',
          playerName: 'Player 2-3',
          points: '10'
        },
        {
          role: 'F',
          playerName: 'Player 2-4',
          points: '29'
        },
        {
          role: 'C',
          playerName: 'Player 2-5',
          points: '31'
        }
      ]
    },
  ]
  @track teamColumns=
  [
    {label:'Team Name', fieldName: 'teamName'},
    {label:'Role', fieldName:'role'},
    {label:'Player Name', fieldName:'playerName'},
    {label:'Points (AVG)', fieldName:'points'},
  ]

}