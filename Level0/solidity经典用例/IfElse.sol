// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract IfElse {
    function test1(uint x) public pure returns(uint) {
        if (x > 10) {
            return 10;
        }else if (x == 10) {
            return 9;
        }else {
            return 8;
        }
    }

    function test2 (uint y) public pure returns(uint) {
        return y > 10 ? y : 10;
    }
}