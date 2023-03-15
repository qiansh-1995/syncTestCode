import { ethers } from "hardhat";

async function main() {
    const accounts = await ethers.getSigners();
    addWhitelist ='0x59DD5c6130db837672fB74eE1ab4E87c1B0E62cf'
    for (const account of accounts) {
      console.log(account.address);
      const contractBalance = await ethers.provider.getBalance(account.address)
      console.log(contractBalance)
      console.log(ethers.utils.formatEther( contractBalance ))
      const addRes= await ethers.provider.addWhitelist
    }

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
