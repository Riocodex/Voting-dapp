const { expect } = require("chai");
const { ethers } = require("hardhat");

describe('Viewapp', ()=>{
    let person, viewContract

    it('saves the address',async()=>{
        [ person ] = await ethers.getSigners()
         //deploy view app
      const ViewContract = await ethers.getContractFactory('View')
      viewContract = await ViewContract.deploy()
    //   console.log(viewContract.address)
    })
    
    it('multiplies the numbers',async()=>{
        await viewContract.connect(person).multiplyTwoNumbers(2,2)
        let result = await viewContract.seeResult()
        expect(result).to.be.equal(4)
    })
     
      
})