// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract Owner {
    struct Identity {
        address addr;
        string name;
    }

    enum Status {
        HasOwner,
        NoOwner
    }

    event OwnerSet(address indexed oldOwnerAddr, address indexed newOwnerAddr);
    event OwnerRemoved(address indexed oldOwnerAddr);

    Identity private iden;
    Status private status;

    modifier isOwner() {
        require(msg.sender == iden.addr, 'Caller is not owner');
        _;
    }

    // uint[][2] u22;

    constructor(string memory _name) {
        iden = Identity({
            addr: msg.sender,
            name: _name
        });
        status = Status.HasOwner;
        emit OwnerSet(address(0), msg.sender);
        uint[3][2] memory arr = [
            [uint(1), 2, 3],
            [uint(1), 2, 3]
        ];
    }

    function changeOwner(address addr, string memory _name) public isOwner {
        iden.addr = addr;
        iden.name = _name;
    }

    function removeOwner() public {
        delete iden;
        status = Status.NoOwner;
        emit OwnerRemoved(msg.sender);
    }

    function getOwner() public view returns(address, string memory){
        return (iden.addr, iden.name);
    }

    function getState() public view returns(Status) {
        return status;
    }

    function getValue() public payable returns (address, uint, uint, bytes memory, bytes32) {
        address _addr = address(this);
        return (msg.sender, msg.value, _addr.balance, _addr.code, _addr.codehash);
    }
}