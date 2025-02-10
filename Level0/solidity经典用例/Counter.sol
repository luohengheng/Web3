// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract Counter {
    uint256 public counter;

    function increment() public {
        counter += 1;
    }

    function decrement() public {
        counter -= 1;
    }

    function get() public view returns (uint256) {
        return counter;
    }
}