// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract IDOToken is ERC20, Ownable {
    uint public  price = 0.1 * 10 ** 18;
    uint public  maxNum = 10000;
     // 定义 USDT 代币的地址
    address public usdtAddress = 0x606D35e5962EC494EAaf8FE3028ce722523486D2; 
    mapping(address => uint) bugMap;


    constructor(address usdtAddress_) ERC20("AXS Token", "AXS") Ownable(msg.sender) {
        usdtAddress = usdtAddress_;
    }

    function  bug(uint amount) public {
        require(bugMap[msg.sender] + amount < maxNum, "chao le max");
        IERC20(usdtAddress).transferFrom(msg.sender, address(this), amount);
        uint num = amount / price  * 10 ** 18;
        bugMap[msg.sender] = num;
    } 

    function withdrow() public onlyOwner {
        uint balance = IERC20(usdtAddress).balanceOf(address(this));
        IERC20(usdtAddress).transfer(msg.sender, balance);
    }
}