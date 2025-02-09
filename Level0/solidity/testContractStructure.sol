// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract TestContractStructure {
    uint256 public  blance;

    constructor(uint256 _bal) {
        blance = _bal;
    }

    event BalanceAdded(uint256 oldVal, uint256 incr); // 事件 === 日志

    modifier IncrementRange(uint256 _incr) {
        // 修饰器是对函数的输入输出条件进行约束的
        require(_incr > 100, 'too smalll');
        _;
    }

    function blance1() internal  view returns (uint256) {
        return  blance;
    }

    function addBalance(uint256 _incre) external  IncrementRange(_incre) {
        uint256 old = blance;
        blance += _incre;
        emit BalanceAdded(old, _incre);
    }
}