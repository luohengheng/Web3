// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract Variables {
    // state variables
    string public text = 'hello';
    uint256 public u256 = 123;

    function doSomething() public {
        // local variable
        uint256 i = 456;

        // global variable
        uint256 timestamp = block.timestamp;
        address add = msg.sender;
    }
}