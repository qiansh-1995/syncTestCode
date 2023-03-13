import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  defaultNetwork: "bsctestnet",
  networks: {
    bsctestnet: {
      url: "https://bsc-testnet.public.blastapi.io/",
      chainId:97,
      accounts: ['3c3211ea05c3e671e606218c9991ad571c0f2bef420cb0a743267ea36498712d'],
      gas: 2100000,
      gasPrice: 8000000000,
    }
  }
};

export default config;
