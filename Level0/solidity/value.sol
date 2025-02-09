// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract Value {
    uint256 public tokenBalance;

    constructor() public {
        tokenBalance = 0;
    }

    function addValue() payable public {
        tokenBalance = tokenBalance + (msg.value / 10);
    }

    function getTokenBalance() view public returns(uint256) {
        return tokenBalance;
    }
}