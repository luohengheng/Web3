// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract Enum {
    enum Status {
        One,
        Two,
        Three
    }

    // 默认值是第一个元素
    Status public status;

    function get() public view returns(Status, Status) {
        return (status, Status.One);
    }

    function set(Status _status) public {
        status = _status;
    }

    function reset() public {
        delete status;
    }
}