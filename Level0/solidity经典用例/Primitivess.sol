// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract Primitives {
    bool public boo = true;

    uint8 public u8 = 1;
    uint256 public u256 = 456;
    uint public u = 123; // uint == uint256

    int8 public i8 = -111;
    int256 public i256 = 456;
    int256 public i = -123; // int == int256

    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    address public addr = address(this);

    bytes3 public a = 0x111111;
    bytes1 public b = 0x11;

    // variable default value
    bool public defaultB; // false
    uint256 public defaultUint256; // 0
    int256 public defaultInt256; // 0
    address public defaultAddr; // 0x0000000000000000000000000000000000000000
}