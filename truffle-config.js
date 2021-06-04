require("dotenv").config();

const HDWalletProvider = require("@truffle/hdwallet-provider");
const mnemonic = process.env.MNEUMONIC;
const bscMainNet = process.env.BSC_MAINNET;
const bscTestNet = process.env.BSC_TESTNET;
const etherscanApiKey = process.env.ETHERSCAN_API_KEY;
const bscscanApiKey = process.env.BSCSCAN_API_KEY;
const fromAddress = process.env.FROM_ADDRESS;

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*",
    },
    ropsten: {
      provider: () =>
        new HDWalletProvider(
          mnemonic,
          `https://ropsten.infura.io/v3/${infuraKey}`
        ),
      network_id: 3,
      gas: 5500000,
      confirmations: 2,
      from: fromAddress,
    },
    kovan: {
      provider: () =>
        new HDWalletProvider(
          mnemonic,
          `wss://kovan.infura.io/ws/v3/${infuraKey}`
        ),
      network_id: 42,
      gas: 6721975,
      gasPrice: 10000000000,
      networkCheckTimeout: 10000000,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
      from: fromAddress,
    },
    main: {
      provider: () =>
        new HDWalletProvider(
          mnemonic, bscMainNet
        ),
      network_id: 56,
      confirmations: 10,
      timeoutBlocks: 200,
      networkCheckTimeout: 10000000,
      skipDryRun: true,
      from: fromAddress,
    },
    bsctest: {
      provider: () =>
        new HDWalletProvider(
          mnemonic, bscTestNet
        ),
      network_id: 97,
      confirmations: 2,
      timeoutBlocks: 200,
      gas: 6721975,
      gasPrice: 10000000000,
      networkCheckTimeout: 10000000,
      skipDryRun: true,
      from: fromAddress,
    }
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.4",
      settings: {
        optimizer: {
          enabled: false,
          runs: 200,
        },
        evmVersion: "byzantium",
      },
    },
  },

  plugins: ["truffle-plugin-verify"],

  api_keys: {
    etherscan: etherscanApiKey,
    bscscan: bscscanApiKey
  },
};
