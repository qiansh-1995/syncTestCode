import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  defaultNetwork: "bsctestnet",
  networks: {
    bsctestnet: {
      url: "https://bsc-testnet.public.blastapi.io/",
      chainId:97,
      accounts: ['7a1ef0db2ef41ad6c21c1de7d470a6829c70cad243505f2dc128c3db2066eab2']
    }
  }
};

export default config;
