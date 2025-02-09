// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract TestAddress {
    address public myAddress1 = 0x1234567890123456789012345678901234567890;
    address myAddress2 = msg.sender;

    function compareAddress() public view returns (bool) {
        if (myAddress1 == myAddress2) {
            return true;
        } else {
            return false;
        }
    }

    function handleTransfer() public {
        address payable payableAddress = payable(myAddress1);
        uint256 balance = myAddress1.balance;
        address payable recipient = payable(0x1234567890123456789012345678901234567890);
        recipient.transfer(1 ether);
    }

    // 白名单机制，支付合约
    mapping(address => bool) public whiteList;

    function addToWhiteList(address _address) public {
        whiteList[_address] = true;
    }

    function isWhiteListed(address _address) public view returns(bool) {
        return whiteList[_address];
    }

    // 授权支付合约
    function pay(address payable recipient) public payable {
        require(whiteList[recipient], 'Recipient is not whiteListed');
        recipient.transfer(msg.value);
    }
}
