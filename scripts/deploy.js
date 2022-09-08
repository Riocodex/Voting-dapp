
const hre = require("hardhat");

async function main() {

  const VotingContract = await hre.ethers.getContractFactory("Voting");
  const votingContract = await VotingContract.deploy();

  await votingContract.deployed();

  console.log("VotingContract deployed to:", votingContract.address);
}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
