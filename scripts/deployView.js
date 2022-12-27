const hre = require("hardhat")

async function main(){
    const ViewContractFactory = await hre.ethers.getContractFactory("Voting")
    const viewContract = await ViewContractFactory.deploy()
    await viewContract.deployed()

    console.log("View Contract deployed to ", viewContract.address)

    const [person] = await hre.ethers.getSigners();

    await viewContract.connect(person).multiplyTwoNumbers(2,2)

    let result = await viewContract.seeResult()
    console.log("this is the result",result)
}