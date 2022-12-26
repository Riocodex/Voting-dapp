const { expect } = require("chai");
const { ethers } = require("hardhat");

const money = {value: hre.ethers.utils.parseEther("10")};

describe('Votingapp', ()=>{
    let electionOwner, candidate1, candidate2, candidate3, voter1, voter2,  voter3, voter4
    let votingContract

    it('saves the addresses', async() =>{

        //setup accounts
        [electionOwner, candidate1, candidate2, candidate3, voter1, voter2,  voter3, voter4] = await ethers.getSigners()

        //deploy Voting app
        const VotingContract = await ethers.getContractFactory('Voting')
        votingContract = await VotingContract.deploy()
        console.log(votingContract.address)
    })
    it('starts election', async () =>{
           //start Election
           let transaction = await votingContract.connect(electionOwner).startElection("sexiest",20,money)
           await transaction.wait()

           let returnElectionDetails = await votingContract.getElectionDetails();
           expect( returnElectionDetails.title).to.be.equal('sexiest')
    })



    it('allows users to register', async()=>{
        //register as candidates
        await votingContract.connect(candidate1).register('rio' , money);
        await votingContract.connect(candidate2).register('patrick' , money);
        await votingContract.connect(candidate3).register('king' , money);
    })
    
    it('allows users to view candidates of the election', async() =>{
        //view candidates
        //return candidates
        let candidates = await votingContract.getCandidates();
    })

    it('allows users to vote', async () =>{
        //voting operation
        await votingContract.connect(voter1).vote('rio' , money);
        await votingContract.connect(voter2).vote('rio' , money);
        await votingContract.connect(voter3).vote('patrick' , money);
        await votingContract.connect(voter4).vote('king' , money);
    })

    it('picks a winner', async() =>{
            //return winner
        let winner = await votingContract.viewWinner();
        
    })


})
