const { expect } = require("chai");
const { ethers } = require("hardhat");

const tokens = (n) =>{
    return ethers.utils.parseUnits(n.toString(), 'ether')
}

describe('Votingapp', ()=>{
    it('saves the addresses', async() =>{
        const VotingContract = await ethers.getContractFactory('Voting')
        votingContract = await VotingContract.deploy()

        console.log(votingContract.address)
    })
})
