// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

error Voting__SendMoreEthToVote();
error Voting__ElectionNotOpen();

contract Voting{
    //type declarations
    enum ElectionState{
        OPEN,
        BUSY
    }
    enum IsElection{
        NO,
        YES
    }

    //variables
    uint256 private s_contractStartTime;
    ElectionState private s_electionState;
    IsElection private s_isElection;
    string public votingTitle;
    uint256 registrationPeriod;
    uint256 electionEndingTime;
    uint256 electionStartTime;

    

    constructor(){
        s_contractStartTime = block.timestamp;
        s_electionState = ElectionState.OPEN;
        s_isElection = IsElection.NO;

    }

    function startElection(string memory _title , uint256 _registrationPeriod , uint256 _endingTime)public payable{
        if(msg.value  < 0.2 ether){
            revert Voting__SendMoreEthToVote();
        }
        if(s_electionState != ElectionState.OPEN){
            revert Voting__ElectionNotOpen();
        }
        votingTitle = _title;
        registrationPeriod = _registrationPeriod;
        electionEndingTime = _endingTime;
        s_electionState = ElectionState.BUSY;
        s_isElection = IsElection.YES;
        electionStartTime = block.timestamp;

    }
}