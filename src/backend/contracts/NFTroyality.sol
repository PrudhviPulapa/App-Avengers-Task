//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTRoyalty is ERC721 {

  uint256 public royalty;

  constructor(string memory name, string memory symbol) ERC721(name, symbol) {
    royalty = 10; // 10% royalty
  }

  function setRoyalty(uint256 newRoyalty) public {
    royalty = newRoyalty;
  }

  function getRoyalty() public view returns (uint256) {
    return royalty;
  }
}