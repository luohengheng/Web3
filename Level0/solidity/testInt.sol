pragma solidity 0.8.20;

contract TestInt {
    int8 a = -1;
    int16 b = 2;
    uint32 c = 10;
    uint8 d = 16;

    function add(uint x, uint y) public pure returns (uint z) {
        return x+ y;
    }

    function divide(uint x, uint y) public pure returns (uint z) {
        return x / y;
    }

    function leftShift(uint x, uint y) public pure returns (uint z) {
        return x << y;
    }

    function rightShift(uint x, uint y) public pure returns (uint z) {
        return x >> y;
    }

    function testPlusPlus() public pure returns(uint) {
        uint x = 1; uint y = ++x;
        return y;
    }
}