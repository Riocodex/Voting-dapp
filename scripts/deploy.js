
const hre = require("hardhat");

async function main() {
//connecting the contract 
  const VotingContractFactory = await hre.ethers.getContractFactory("Voting");
  const votingContract = await VotingContractFactory.deploy();
  await votingContract.deployed();
//console.logging the value
  console.log("VotingContract deployed to:", votingContract.address);

  //operations
//statevariables
//candidate accounts
const [owner, tipper, tipper2, tipper3 , tipper4 ] = await hre.ethers.getSigners();

//voters accounts
const [voter1 , voter2 ,voter3 , voter4] = await hre.ethers.getSigners();

//start election
await votingContract.connect(tipper).startElection('deployer' , 20 , 2000);

//register as candidates
await votingContract.connect(tipper2).register('rio');
await votingContract.connect(tipper3).register('patrick');
await votingContract.connect(tipper4).register('king');

//voting operation
await votingContract.connect(voter1).vote('rio');
await votingContract.connect(voter2).vote('rio');
await votingContract.connect(voter3).vote('patrick');
await votingContract.connect(voter4).vote('king');

//deciding winner
await votingContract.decideWinner();

//return electionDetails
let returnElectionDetails = await votingContract.getElectionDetails();
console.log('Election Details are: ', returnElectionDetails);

//return candidates
let candidates = await votingContract.getCandidates();
console.log("candidates for the election are: ", candidates);

//return winner
let winner = await votingContract.viewWinner(2);
console.log("and the winner of this eletion is...." , winner);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
