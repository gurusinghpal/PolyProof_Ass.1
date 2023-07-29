// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "erc721a/contracts/ERC721A.sol";

contract MyNFT is ERC721A {
    address public owner;

    uint256 public maxNFT = 5;

    string private _prompt;

    string baseUrl =
        "https://gateway.pinata.cloud/ipfs/QmazecZKL8hWb2uTP5JyetJcbueotwLa2q2Payz6u1CewT/";

    constructor(string memory prompt) ERC721A("MyNFT", "NFT") {
        owner = msg.sender;
        _prompt = prompt;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "This action can only be performed by the Owner!");
        _;
    }

    function mint(uint256 quantity) external payable onlyOwner {
        require(
            totalSupply() + quantity <= maxNFT,
            "Sorry! You can not mint more than 5 NFTs"
        );
        _mint(msg.sender, quantity);
    }

    // Override the baseURI function to return the base URL for the NFTs
    function _baseURI() internal view override returns (string memory) {
        return baseUrl;
    }

    // Return the URL for the prompt description
    function promptDescription() external view returns (string memory) {
        return _prompt;
    }
}
