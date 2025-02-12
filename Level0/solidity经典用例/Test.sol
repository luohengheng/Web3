// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Test {
    
    function a() public {
        bytes32 b1 = blockhash(100);
        address addr = block.coinbase;
        uint timestamp = block.timestamp;
        uint remainingGas = gasleft();
    }
}

