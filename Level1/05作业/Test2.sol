// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BoredApeClone is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    uint256 public constant MAX_SUPPLY = 10000; // 最大供应量
    uint256 public constant MINT_PRICE = 0.08 ether; // 铸造价格
    string public baseTokenURI; // 基础 URI

    constructor(string memory baseURI) ERC721("BoredApeClone", "BAC") Ownable(msg.sender) {
        baseTokenURI = baseURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    function mint(uint256 numberOfTokens) public payable {
        require(totalSupply() + numberOfTokens <= MAX_SUPPLY, "Exceeds max supply");
        require(msg.value >= MINT_PRICE * numberOfTokens, "Ether sent is not correct");

        for (uint256 i = 0; i < numberOfTokens; i++) {
            _safeMint(msg.sender, _tokenIdCounter.current());
            _tokenIdCounter.increment();
        }
    }

    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter.current();
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }
}