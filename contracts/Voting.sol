// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

error Voting__SendMoreEthToVote();
error Voting__ElectionNotOpen();
error Voting__RegisterationPeriodOver();
error Voting__EndOfElection();
error Voting__UserAlreadyExists();
error Voting__UserDoesntExist();
error Voting__YouHaveAlreadyVoted();

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
    struct VoterDetails{
        address owner;
    }
    mapping(address => VoterDetails) public addresstoVoters;

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
    uint256 highestVotes = 0;
    string winner;
    CandidateDetails[] winnerDetails;

    

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
    function register(string memory _name)public{
        //if election is not open
        if(s_electionState != ElectionState.BUSY){
            revert Voting__ElectionNotOpen();
        }
        //if registeration time is already over
        // if(electionStartTime - block.timestamp > registrationPeriod){
        //     revert Voting__RegisterationPeriodOver();
        // }
        //if user name already exists
        for(uint256 i = 0; i < candidates.length ; i++){
            if( keccak256(abi.encodePacked((candidates[i].name))) == keccak256(abi.encodePacked((_name)))){
                revert Voting__UserAlreadyExists();
            }
        }
        //if user address already exists
         for(uint256 i = 0; i < candidates.length ; i++){
            if( candidates[i].owner == msg.sender){
                revert Voting__UserAlreadyExists();
            }
        }
        
        
        numToCandidate[_name]=CandidateDetails(
            _name,
            msg.sender,
            votes
        );
        candidates.push(CandidateDetails(
            _name,
            msg.sender,
            votes
        ));    
    }
    function vote(string memory _name)public{
          //if election is not open
        if(s_electionState != ElectionState.BUSY){
            revert Voting__ElectionNotOpen();
        }
           //if user name doesnt exists
        // for(uint256 i = 0; i < candidates.length ; i++){
        //     if( keccak256(abi.encodePacked((candidates[i].name))) == keccak256(abi.encodePacked((_name)))){
        //         revert Voting__UserDoesntExist();
        //     }
        // }
        //if voter has already voted before
        if(addresstoVoters[msg.sender].owner == msg.sender){
            revert Voting__YouHaveAlreadyVoted();
        }
        numToCandidate[_name].numVotes++;
        //to update value to the array
        for(uint256 i = 0; i<candidates.length; i++){
            if(keccak256(abi.encodePacked((candidates[i].name))) == keccak256(abi.encodePacked((_name)))){
                candidates[i].numVotes++;
            }
        }
        //adding users to voters array
        addresstoVoters[msg.sender]=VoterDetails(
            msg.sender
        );
    }
    

    //getter functions
     function getCandidates()public view returns(CandidateDetails[] memory){
        return candidates;
    }
        function check(uint256 _num)public view returns(uint256){
            return candidates[_num].numVotes;
        }
    function decideWinner()public {
        for(uint256 i = 0; i<candidates.length; i++){
            if(candidates[i].numVotes > highestVotes ){
                highestVotes = candidates[i].numVotes ;   
            }
        }
        for(uint256 i = 0; i< candidates.length; i++){
            if(candidates[i]. numVotes == highestVotes){
                winner = candidates[i].name;
            }
        }
        
    }
    function viewWinner(uint256 /*sum*/)public view returns (string memory name){
        return winner;
    }
    
    function getElectionDetails()public view returns(ElectionDetails memory){
         if(s_electionState != ElectionState.BUSY){
            revert Voting__ElectionNotOpen();
        }
        return elections[elections.length-1];
    }

}