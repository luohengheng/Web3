// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract SolidityTest {
    uint storageData; // 状态变量
    constructor() public {
        storageData = 10;
    }

    function getResult() public view returns (uint) {
        uint a = 1; // 局部变量
        uint b = 2;
        uint result = a + b;
        return result;
    }

    // blockhash(blockNumber) returns (bytes32) ;
    // block.coinbase;
    // block.difficulty;
    // block.gaslimit;
    // block.number;
    // block.timestamp;
    // gasleft() returns (uint256)
    // now(uint);
}
