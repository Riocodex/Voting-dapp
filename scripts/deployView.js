const hre = require("hardhat")

async function main(){
    const ViewContractFactory = await hre.ethers.getContractFactory("Voting")
    const viewContract = await ViewContractFactory.deploy()
    await viewContract.deployed()

    console.log("View Contract deployed to ", viewContract.address)
    
}