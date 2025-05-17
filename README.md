# Tokenized Manufacturing Equipment Marketplace

## Overview

This project implements a decentralized marketplace for industrial manufacturing equipment using blockchain technology and tokenization. The platform enables secure, transparent, and efficient buying and selling of industrial machinery through digital asset representation, smart contract automation, and decentralized verification mechanisms.

## Key Components

### 1. Seller Verification Contract
- Validates the identity and credentials of equipment owners
- Implements KYC/AML compliance procedures
- Maintains reputation and trust scores for marketplace participants
- Provides dispute resolution mechanisms
- Stores seller credentials and certification documents

### 2. Asset Registration Contract
- Records comprehensive details of industrial machinery
- Creates unique non-fungible tokens (NFTs) representing each piece of equipment
- Stores technical specifications, operational history, and documentation
- Manages equipment metadata including:
    - Manufacturer information
    - Model and serial numbers
    - Production capacity and specifications
    - Manufacturing date and service history
    - Compatible systems and integration points

### 3. Condition Verification Contract
- Validates and certifies the current condition of equipment
- Integrates with IoT devices for real-time condition monitoring
- Manages inspection records and maintenance history
- Stores performance metrics and diagnostic reports
- Implements verification through trusted third-party inspectors

### 4. Transaction Escrow Contract
- Manages secure payment and settlement between parties
- Implements multi-stage transaction processes with verification gates
- Supports multiple payment options (cryptocurrency, stablecoins, fiat gateways)
- Handles partial payments, financing options, and installment plans
- Provides automated tax calculation and reporting

### 5. Transfer Verification Contract
- Records and validates ownership changes
- Manages asset delivery and receipt confirmation
- Updates regulatory compliance records
- Handles title transfers and related documentation
- Integrates with logistics and delivery verification systems

## Technical Architecture

The system is built on Ethereum with the following components:

- **Smart Contracts**: Written in Solidity (v0.8.x)
- **Token Standard**: ERC-721 for unique equipment tokenization
- **Off-chain Storage**: IPFS for equipment documentation and large data files
- **Oracle Services**: Chainlink for external data verification and real-world integration
- **Front-end Interface**: React application with Web3 integration
- **Backend Services**: Node.js server for off-chain processing and API integrations

## Getting Started

### Prerequisites
- Node.js (v16+)
- Truffle Framework or Hardhat
- MetaMask or similar Web3 wallet
- Ethereum account with testnet ETH for development

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/tokenized-equipment-marketplace.git

# Install dependencies
cd tokenized-equipment-marketplace
npm install

# Compile smart contracts
npx hardhat compile

# Deploy to local blockchain
npx hardhat run scripts/deploy.js --network localhost

# Run the frontend application
cd frontend
npm install
npm start
```

### Configuration

Configure the marketplace by updating the `config.js` file:

```javascript
module.exports = {
  // Blockchain network settings
  network: {
    mainnet: "https://mainnet.infura.io/v3/YOUR_INFURA_KEY",
    testnet: "https://sepolia.infura.io/v3/YOUR_INFURA_KEY",
    development: "http://localhost:8545"
  },
  
  // Verification parameters
  verification: {
    requiredInspectors: 2,
    disputeTimeWindow: 604800, // 7 days in seconds
    reputationThreshold: 80 // Minimum reputation score for sellers
  },
  
  // Escrow settings
  escrow: {
    releaseTimelock: 172800, // 48 hours in seconds
    feePercentage: 1.5, // Platform fee
    disputeResolutionAddress: "0x123..." // Multi-sig wallet for dispute resolution
  },
  
  // Asset registration parameters
  assetRegistration: {
    minimumRequiredFields: ["manufacturer", "model", "serialNumber", "productionYear"],
    supportedCategories: ["CNC", "Robotics", "Injection Molding", "Assembly", "Packaging"]
  }
};
```

## Usage Examples

### Registering New Equipment

```javascript
const AssetRegistration = artifacts.require("AssetRegistration");

module.exports = async function(callback) {
  const assetContract = await AssetRegistration.deployed();
  
  // IPFS hash containing detailed equipment documentation
  const documentationIpfsHash = "QmZ9...";
  
  await assetContract.registerEquipment(
    "CNC Milling Machine",
    "Haas Automation",
    "VF-2SS",
    "123456789",
    2020, // Manufacturing year
    documentationIpfsHash,
    {
      maxRPM: 12000,
      axisCount: 5,
      workEnvelope: "30x16x20 inches",
      powerRequirement: "240V 3-phase"
    },
    { from: sellerAccount }
  );
  
  callback();
};
```

### Creating a Sale Listing

```javascript
const Marketplace = artifacts.require("Marketplace");

module.exports = async function(callback) {
  const marketplace = await Marketplace.deployed();
  
  const tokenId = 1; // ID of the registered equipment NFT
  const priceInEth = web3.utils.toWei("25", "ether");
  const offerValidityPeriod = 30 * 24 * 60 * 60; // 30 days in seconds
  
  await marketplace.createListing(
    tokenId,
    priceInEth,
    offerValidityPeriod,
    { from: sellerAccount }
  );
  
  callback();
};
```

### Completing a Transaction

```javascript
const TransactionEscrow = artifacts.require("TransactionEscrow");

module.exports = async function(callback) {
  const escrow = await TransactionEscrow.deployed();
  
  const listingId = 1;
  
  // Buyer initiates purchase by depositing funds
  await escrow.initiateTransaction(listingId, {
    from: buyerAccount,
    value: web3.utils.toWei("25", "ether")
  });
  
  // After inspection, buyer confirms receipt
  await escrow.confirmReceipt(listingId, {
    from: buyerAccount
  });
  
  // Funds are released to seller automatically after confirmation
  
  callback();
};
```

## Security Considerations

- **Access Control**: Role-based permissions using OpenZeppelin's AccessControl
- **Reentrancy Protection**: Guards against reentrancy attacks in all fund transfer functions
- **Circuit Breakers**: Emergency pause functionality for critical contract operations
- **Escrow Protection**: Multi-signature requirements for large transactions
- **Oracle Security**: Decentralized oracle networks for external data feeds
- **Audit History**: Smart contracts audited by [Security Audit Partner]
- **Insurance Options**: Coverage available for high-value transactions

## Future Roadmap

- **Q3 2025**: Launch marketplace with core functionality
- **Q4 2025**: Implement fractional ownership capabilities
- **Q1 2026**: Add equipment leasing and rental options
- **Q2 2026**: Develop IoT integration for real-time equipment monitoring
- **Q3 2026**: Implement predictive maintenance services
- **Q4 2026**: Create secondary market for equipment parts and accessories
- **2027**: Expand to international markets with multi-currency support

## Business Model

- **Transaction Fees**: 1.5% fee on completed equipment sales
- **Verification Services**: Fee for expedited verification process
- **Premium Listings**: Enhanced visibility for featured equipment
- **Escrow Services**: Secure payment processing
- **Data Analytics**: Anonymized market data and insights
- **Finance Options**: Equipment financing through partner institutions

## Contributing

We welcome contributions from the manufacturing and blockchain communities. Please see [CONTRIBUTING.md](./CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

## Acknowledgments

- [Manufacturing Industry Partners]
- [Blockchain Development Partners]
- [IoT Technology Providers]

## Contact

- Website: [www.tokenizedequipment.io](http://www.tokenizedequipment.io)
- Email: info@tokenizedequipment.io
- Twitter: [@TokenizedEquip](https://twitter.com/TokenizedEquip)
- Discord: [Tokenized Equipment Community](https://discord.gg/tokenizedequipment)
