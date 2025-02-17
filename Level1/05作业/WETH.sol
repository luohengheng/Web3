// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract WETH {
    mapping (address=>uint) balanceOf;
    mapping (address => mapping (address => uint)) allowance;

    // event Transfer,Approval
    event TransferFromEvent(address src, address to, uint amount);
    event DepositEvent(address addr, uint amount);
    event WithDrawEvent(address addr, uint amount);
    event ApproveEvent(address src, address delegateAds, uint amount);

    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit DepositEvent(msg.sender, msg.value);
    }

    function withDraw(uint amount) public {
        require(balanceOf[msg.sender] < amount, 'no money');
        payable(msg.sender).transfer(amount);
        balanceOf[msg.sender] -= amount;
        emit WithDrawEvent(msg.sender, amount);
    }

    function totalSupply() public view returns(uint) {
        return address(this).balance;
    }

    function approve(address addr, uint amount) public returns(bool) {
        allowance[msg.sender][addr] = amount;
        emit ApproveEvent(msg.sender, addr, amount);
        return true;
    }

    function transferFn(address src, address to, uint amount) public returns(bool) {
        return transferFrom(src , to, amount);
    }

    function transferFrom(address src, address to, uint amount) internal returns(bool) {
        require(balanceOf[src] > amount, 'balance xiaoyu amount');
        balanceOf[src] -= amount;
        balanceOf[to] += amount;
        payable(src).transfer(amount);
        emit TransferFromEvent(src, to, amount);
        return true;
    }

    receive() external payable {
        deposit();
    }

    fallback() external payable {
        deposit();
    }
}