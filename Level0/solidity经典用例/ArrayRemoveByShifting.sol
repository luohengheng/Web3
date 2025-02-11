// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

// 通过从右向左移动元素来删除数组元素
contract ArrayRemoveByShifting {
    uint[] public arr;

    function remove(uint index) public {
        require(index < arr.length, 'index out bound');

        for (uint i = index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }

        arr.pop();
    }

    function test() public returns( uint[] memory) {
        arr = [1,2,3,4,5,6];
        remove(2);
        return arr;
    }
}