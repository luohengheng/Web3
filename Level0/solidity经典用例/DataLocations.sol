// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract DataLocations {
    uint[] public arr;
    mapping(uint => address) map;

    struct MyStruct {
        uint foo;
    }
    mapping(uint => MyStruct) myStructs;

    function f() public {
        MyStruct storage myStruct = myStructs[1];
        MyStruct memory myMemStruct = MyStruct(1);
    }

    function _f(uint[] storage arr, mapping(uint => address) storage _map, MyStruct storage _myStruct) internal {

    }
}