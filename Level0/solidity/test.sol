// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract Base {
    uint a;
    constructor() {
        
    }

    function add(uint x) external {
        a = a + x;
    }

    function increase() public {
        this.add(1);
    }
}