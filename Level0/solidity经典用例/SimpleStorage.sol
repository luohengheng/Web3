// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity  0.8.20;

contract SimpleStorage {
    uint256 public u256;

    function write(uint num) public {
        u256 = num;
    }

    function get() public view returns(uint) {
        return u256;
    }
}