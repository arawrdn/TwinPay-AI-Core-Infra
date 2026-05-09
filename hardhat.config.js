require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    // Celo Alfajores Testnet
    alfajores: {
      url: "https://alfajores-forno.celo-testnet.org",
      accounts: [process.env.PRIVATE_KEY],
    },
    // Celo Mainnet
    celo: {
      url: "https://forno.celo.org",
      accounts: [process.env.PRIVATE_KEY],
    }
  },
  etherscan: {
    // Used for verification on Celoscan
    apiKey: {
      alfajores: process.env.CELOSCAN_API_KEY,
      celo: process.env.CELOSCAN_API_KEY
    },
  },
};
