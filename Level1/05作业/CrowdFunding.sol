// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract CrowdFunding {
    string targetName;
    uint256 public  immutable fundingGoal;
    uint256 public fundingAmount;
    string[] fundersList;
    uint fundersKey;
    mapping(string => mapping (address => uint)) funders;
    mapping (string=>bool) fundersIsExist;

    constructor(string memory _name, uint256 _targetMoney) {
        targetName = _name;
        fundingGoal = _targetMoney;
    }

    function contribute(string memory name) public payable returns (uint) {
        require(fundingAmount < fundingGoal, 'to target');
        
        if (fundersIsExist[name]) {
            funders[name][msg.sender] += msg.value;
        } else {
            fundersIsExist[name] = true;
            funders[name][msg.sender] = msg.value;
            fundersList.push(name);
        }
        fundingAmount += msg.value;
        uint refundAmount = fundingAmount - fundingGoal;

        // 返还多余费用
        if (refundAmount > 0) {
            payable(msg.sender).transfer(refundAmount);
        } 
        return  refundAmount;
    }

    function getFundingInfo() public view returns(string[] memory){
        return (fundersList);
    }
}