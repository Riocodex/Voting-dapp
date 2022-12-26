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

        //start Election
        let transaction = await votingContract.connect(electionOwner).startElection("sexiest man",20,money)
        await transaction.wait()
    })
})