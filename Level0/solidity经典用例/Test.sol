// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

// 练习：实现一个简单的存款和取款合约
contract SimpleWallet {
    mapping(address => uint256) public  balance;

    function withdraw(uint256 amount) public {
        require(balance[msg.sender] < amount, "insufficient balance");
        balance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }

    function checkBalance() public view returns(uint256) {
        return balance[msg.sender];
    }
}