/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: '0.8.9',
    defaultNetwork: 'goerli',
    networks: {
      hardhat: {},
      goerli: {
        url: 'https://rpc.ankr.com/eth_goerli',
        accounts: [`0x${process.env.PRIVATE_KEY}`]
      }
    },
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};


// This is a configuration file for Hardhat, a popular development environment for Ethereum smart contracts.

// The solidity object is used to configure the Solidity compiler settings. Here, it is set to version 0.8.9.

// The defaultNetwork property specifies which network should be used by default. In this case, it is set to the Goerli test network.

// The networks property is an object that defines the different networks that can be used to deploy and test the smart contracts. In this case, it defines two networks: hardhat and goerli. hardhat is the default network provided by Hardhat for local development and testing. goerli is a public test network that is provided by Ankr. The url property specifies the RPC endpoint of the network, and the accounts property is an array of Ethereum addresses that can be used for deploying and interacting with contracts on the network.

// The settings object is used to configure various settings for the Solidity compiler. Here, the optimizer property is used to enable the optimizer, which is a feature of the Solidity compiler that can improve the gas efficiency of the compiled contracts. The runs property specifies how many times the optimizer should run during compilation. In this case, it is set to 200.


