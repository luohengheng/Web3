// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract Array {
    uint256[] public arr;
    uint256[] public arr2  = [1,2,3];
    uint256[10] public fixSizeArr;

    function get() external view returns(uint) {
        return arr2[0];
    }

    function push() external {
        arr2.push(111);
    }

    function pop() external {
        arr2.pop();
    }

    function getLen() external view returns(uint) {
        return arr2.length;
    }

    function remove(uint index) external {
        delete arr2[index];
    }

    function examples(uint size) external {
        uint256[] memory a = new uint256[](size);
    }
}