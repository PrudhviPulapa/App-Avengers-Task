// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Notes from the Project by Prudhvi Pulapa:
// what it this contract?
// this contract is a NFT contract
// what does it do?
// it mints NFTs
// what is the purpose of this contract?
// to mint NFTs
// how does it mint?
// it mints by calling the mint function
// what is the mint function?
// how does mint function work?
// it takes a string as an argument
// it increments the tokenCount
// it mints a token
// it sets the tokenURI
// it returns the tokenCount

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFT is ERC721URIStorage {
    uint public tokenCount;
    constructor() ERC721("DApp NFT", "DAPP"){}
    function mint(string memory _tokenURI) external returns(uint) {
        tokenCount ++;
        _safeMint(msg.sender, tokenCount);
        _setTokenURI(tokenCount, _tokenURI);
        return(tokenCount);
    }
}