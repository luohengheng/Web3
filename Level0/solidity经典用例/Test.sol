// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

library MathLib {
    function add(uint a, uint b) internal pure returns (uint) {
        return a + b;
    }

    function subtract(uint a, uint b) internal pure returns (int) {
        return int(a - b);
    }

    function multiply(uint a, uint b) internal pure returns (uint) {
        return a  *  b;
    }

    function isArrIncludeItem(uint[] memory self, uint _i) external pure returns(bool bol) {
        for (uint i = 0; i < self.length; i++) {
            if (i == _i) {
                bol = true;
                break;
            }
        }
        bol = false;
    }
}

contract Test {
    using MathLib for uint[];

    function test1() external pure returns(uint, uint, int, bool){
        uint res1 = MathLib.add(11, 22);
        int res2 = MathLib.subtract(11, 22);
        uint res3 = MathLib.multiply(11, 22);
        uint[] memory uArr = new uint[](3);
        uArr[0] = 1;
        uArr[1] = 2;
        uArr[2] = 3;
        bool res4 = uArr.isArrIncludeItem(1);
        return (res1, res3, res2, res4);
    }

    function test2() public {
        bytes memory b1 =  abi.encodeWithSignature("test1()");
        bytes memory b2 =  abi.encodeWithSelector(bytes4(keccak256("test1()")));
        address(this).call(b1);
    }
}