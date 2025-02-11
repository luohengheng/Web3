// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract ArrayReplaceFromEnd {
    uint[] public arr;

    function remove(uint _index) internal {
        require(_index < arr.length , unicode'超过下标');
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function test(uint _index) external returns(uint[] memory) {
        arr = [1,2,3,4,5,6];
        remove(_index);
        return arr;
    }
}