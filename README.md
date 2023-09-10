# App-Avengers-Task

### Requirements For the Initial setup
1) Install the NodeJS
2) Install Hardhat

### Setting up
Install Dependencies:
$ cd nft_marketplace
$ npm install

local development blockchain:
$ cd nft_marketplace
$ npx hardhat node

Migrate Smart Contracts:
$ npx hardhat run src/backend/scripts/deploy.js --network localhost

Run Tests:
$ npx hardhat test

Launch Frontend:
$ npm run start
