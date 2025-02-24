// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract ViewAndPure {
    uint public x = 1;

    function addToX(uint y) public view returns(uint) {
        return x + y;
    }

    function add(uint i, uint j) public pure returns(uint) {
        return i + j;
    }
}