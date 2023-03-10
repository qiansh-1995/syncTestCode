import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  defaultNetwork: "bsctestnet",
  networks: {
    bsctestnet: {
      url: "https://bsc-testnet.public.blastapi.io/",
      chainId:97,
      accounts: ['bf324707d1fe83ef8a7c8a2f1a7a97c26d6acec378f2f84a2e752eed6a90aff5']
    }
  }
};

export default config;
