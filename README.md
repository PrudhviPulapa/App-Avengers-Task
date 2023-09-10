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

###BUGS
1) In Create.js file in the frontend folder, I am not able to upload the image
2) I could only encounter the above bug as of now, all the smartcontracts are bug free as you can see after running tests
   
