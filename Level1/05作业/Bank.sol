// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract Bank {
    address private owner;

    event widthDrawEvent(uint balance);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(address(this).balance > 0 && msg.sender == owner, "balance no money");
        _;
    }

    function withDraw() public onlyOwner {
        uint balance = address(this).balance;
        emit widthDrawEvent(balance);
        payable(owner).transfer(balance);
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}