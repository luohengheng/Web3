// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity  0.8.20;

contract Mapping {
    mapping(address => uint) public myMap;

    function get() public view returns(uint) {
        return myMap[msg.sender];
    }

    function set() public {
        myMap[msg.sender] = 1;
    }

    function remove() public {
        delete myMap[msg.sender];
    }
}

contract NestedMapping {
    mapping(address => mapping(uint => bool)) myMap;

    function get(address addr, uint u) public view returns(bool) {
        return myMap[addr][u];
    }

    function set(address addr, uint u) public {
         myMap[addr][u] = true;
    }

    function remove(address addr ,uint u) public {
        delete myMap[addr][u];
    }
}