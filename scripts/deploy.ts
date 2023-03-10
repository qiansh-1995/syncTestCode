import { ethers } from "hardhat";
const hre = require("hardhat");

async function deployLock() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const unlockTime = currentTimestampInSeconds + 60;

  const lockedAmount = ethers.utils.parseEther("0.0001");

  const Lock = await ethers.getContractFactory("Lock");
  const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

  await lock.deployed();

  console.log(
    `Lock with ${ethers.utils.formatEther(lockedAmount)}ETH and unlock timestamp ${unlockTime} deployed to ${lock.address}`
  );
}



async function deployMyFirstLaunchPad() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying crowdsale contract with the account:", deployer.address);
  const Crowdsale = await ethers.getContractFactory("MyFirstLaunchPad")
  const crowdsale = await Crowdsale.deploy();
  await crowdsale.deployed();
  // const tx = await crowdsale.buyTokens({ 
  //   value: hre.ethers.utils.parseEther("0.001")
  // });
  //console.log("Transaction hash of buyTokens:", tx.hash);

  // 
  const tx2 = await crowdsale.addWhitelist(deployer.address);
  console.log("Transaction hash of addwhitelist:", tx2.hash);


  // 
  return crowdsale;

}
async function main() {
  const Lock = await deployLock();
  const ICO = await deployMyFirstLaunchPad()

  console.log("Lock contract address:", Lock.address);
  console.log("ICO contract address:", ICO.address);
}


// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
