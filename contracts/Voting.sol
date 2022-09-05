// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

error Voting__SendMoreEthToVote();
error Voting__ElectionNotOpen();
error Voting__RegisterationPeriodOver();
error Voting__EndOfElection();

contract Voting{
    //type declarations
    enum ElectionState{
        OPEN,
        BUSY
    }
    struct CandidateDetails{
        string name;
        address owner;
        uint256 numVotes;
    }
   
    event CandidateName(string name);
    CandidateDetails[] public candidates;
    mapping(string => CandidateDetails) public numToCandidate;

    //variables
    uint256 private s_contractStartTime;
    ElectionState private s_electionState;
    string public votingTitle;
    uint256 registrationPeriod;
    uint256 electionEndingTime;
    uint256 electionStartTime;
    address owner;
    uint256 votes;

    

    constructor(){
        s_contractStartTime = block.timestamp;
        s_electionState = ElectionState.OPEN;
        owner = msg.sender;
    }

    function startElection(string memory _title , uint256 _registrationPeriod , uint256 _endingTime)public {
        // if(msg.value  < 0.2 ether){
        //     revert Voting__SendMoreEthToVote();
        // }
        if(s_electionState != ElectionState.OPEN){
            revert Voting__ElectionNotOpen();
        }
        votingTitle = _title;
        registrationPeriod = _registrationPeriod;
        electionEndingTime = _endingTime;
        s_electionState = ElectionState.BUSY;
        electionStartTime = block.timestamp;
    }
    function register(string memory name)public{
        if(s_electionState != ElectionState.BUSY){
            revert Voting__ElectionNotOpen();
        }
        numToCandidate[name]=CandidateDetails(
            name,
            msg.sender,
            votes
        );
        candidates.push(CandidateDetails(
            name,
            msg.sender,
            votes
        ));    
    }

    //view functions
    
    

}