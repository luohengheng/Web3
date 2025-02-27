// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Callee {
    function print(uint _x) public  pure  returns(uint){
        return _x;
    }
}

contract Caller {
    address public  _callee;
    uint public xx;

    constructor(address _ca) {
        _callee = _ca;
    }

    function send(uint _x) public  {
        bytes memory cd= abi.encodeWithSignature("print(uint256)", _x);
       (bool suc, bytes memory data) = _callee.call(cd);
        if(!suc) {
            revert('call failed');
        }
        uint res = abi.decode(data, (uint));
        xx = res;
    }
}