// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract MarketplaceWithRoyality is ReentrancyGuard {

    // Variables
    address payable public immutable feeAccount; // the account that receives fees
    uint public immutable feePercent; // the fee percentage on sales 
    uint public itemCount;
    uint public royaltyPercent; // Royalty percentage

    struct Item {
        uint itemId;
        IERC721 nft;
        uint tokenId;
        uint price;
        address payable seller;
        address payable creator; // New field for the original creator
        bool sold;
    }

    // itemId -> Item
    mapping(uint => Item) public items;

    event Offered(
        uint itemId,
        address indexed nft,
        uint tokenId,
        uint price,
        address indexed seller,
        address indexed creator
    );

    event Bought(
        uint itemId,
        address indexed nft,
        uint tokenId,
        uint price,
        address indexed seller,
        address indexed buyer
    );

    constructor(uint _feePercent, uint _royaltyPercent) {
        feeAccount = payable(msg.sender);
        feePercent = _feePercent;
        royaltyPercent = _royaltyPercent; // Initialize the royalty percentage
    }

    // Make item to offer on the marketplace
    function makeItem(IERC721 _nft, uint _tokenId, uint _price, address payable _creator) external nonReentrant {
        require(_price > 0, "Price must be greater than zero");
        // increment itemCount
        itemCount++;
        // transfer nft
        _nft.transferFrom(msg.sender, address(this), _tokenId);
        // add new item to items mapping
        items[itemCount] = Item(
            itemCount,
            _nft,
            _tokenId,
            _price,
            payable(msg.sender),
            _creator, // Set the original creator
            false
        );
        // emit Offered event
        emit Offered(
            itemCount,
            address(_nft),
            _tokenId,
            _price,
            msg.sender,
            _creator // Emit the original creator
        );
    }

    function purchaseItem(uint _itemId) external payable nonReentrant {
        uint _totalPrice = getTotalPrice(_itemId);
        Item storage item = items[_itemId];
        require(_itemId > 0 && _itemId <= itemCount, "Item doesn't exist");
        require(msg.value >= _totalPrice, "Not enough ether to cover item price and market fee");
        require(!item.sold, "Item already sold");
        // Calculate royalty amount
        uint royalty = (item.price * royaltyPercent) / 100;
        // Pay royalty to the creator
        item.creator.transfer(royalty);
        // Pay seller and feeAccount
        item.seller.transfer(item.price - royalty); // Subtract royalty from the seller's payment
        feeAccount.transfer(_totalPrice - item.price); // Subtract seller's payment from the total fee
        // Update item to sold
        item.sold = true;
        // Transfer NFT to buyer
        item.nft.transferFrom(address(this), msg.sender, item.tokenId);
        // Emit Bought event
        emit Bought(
            _itemId,
            address(item.nft),
            item.tokenId,
            item.price,
            item.seller,
            msg.sender
        );
    }

    function getTotalPrice(uint _itemId) view public returns (uint) {
        return ((items[_itemId].price * (100 + feePercent)) / 100);
    }
}
