// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract Immutable {
    address public immutable addr;

    constructor() {
        addr = msg.sender;    
    }
}