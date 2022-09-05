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
    struct ElectionDetails{
        string title;
        uint256 registrationPeriod;
        uint256 electionEnding;
    }
    ElectionDetails[]elections;
    mapping(string => ElectionDetails) public titleToElection;
    
   
    event CandidateName(string name);
    CandidateDetails[] public candidates;
    mapping(string => CandidateDetails) public numToCandidate;

    //variables
    uint256 private s_contractStartTime;
    ElectionState private s_electionState;
    string  votingTitle;
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
        titleToElection[_title] = ElectionDetails(
            _title,
            _registrationPeriod,
            _endingTime
        );
        elections.push(ElectionDetails(
            _title,
            _registrationPeriod,
            _endingTime
        ));


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
        // if(electionStartTime - block.timestamp > registrationPeriod){
        //     revert Voting__RegisterationPeriodOver();
        // }
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
    function vote()public{

    }

    //getter functions
     function getCandidates()public view returns(CandidateDetails[] memory){
        return candidates;
    }
    // function getElectionTitle()public view returns(string memory){
    //      if(s_electionState != ElectionState.BUSY){
    //         revert Voting__ElectionNotOpen();
    //     }
    //     return votingTitle;
    // }

    // function getRegisterationPeriod()public view returns(uint256){
    //      if(s_electionState != ElectionState.BUSY){
    //         revert Voting__ElectionNotOpen();
    //     }
    //     return registrationPeriod;
    // }   
    // function getElectionPeriod()public view returns(uint256){
    //     return electionEndingTime;
    // }
    function getElectionDetails()public view returns(ElectionDetails memory){
         if(s_electionState != ElectionState.BUSY){
            revert Voting__ElectionNotOpen();
        }
        return elections[elections.length-1];
    }

}