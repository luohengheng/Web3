// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract Error {
    function testRequire(uint _i) public pure {
        require(_i> 10, unicode"输入需要大于10");
    }

    function testRevert(uint _i) public pure {
        if (_i < 10) {
            revert(unicode"输入需要大于10");
        }
    }

    uint public num;

    function testAssert(uint _u) public view {
        assert(_u == 10);
    }

    error InsufficientBalance(uint balance, uint withdrawAmount);

    function testCustomError(uint _withdrawAmount) public view {
        uint bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance(bal, _withdrawAmount);
        }
    }
}