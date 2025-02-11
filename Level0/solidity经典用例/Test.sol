// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

// 任务 1：基于映射创建一个简单的用户余额管理系统，并实现余额的增加与查询功能。
// 任务 2：扩展系统，使其能够记录每个用户的交易历史，模拟 Java 的 Map 中键集合的概念。
// 任务 3：结合映射与数组，实现一个简单的排行榜系统，记录并排序用户的积分。
contract Test {
    mapping(address => uint) map;
    mapping(address => Transaction[]) recordMap;
    mapping(address => uint) score;

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    address[] userRanking;

    // 余额管理
    function deposit() public payable {
        require(msg.value > 0, unicode"存款金额必须大于0");

        map[msg.sender] = msg.value;
        recordMap[msg.sender].push(Transaction({
            amount: msg.value,
            timestamp: block.timestamp
        }));
    }

    // 获取历史交易记录
    function getHisttoryRecord() public view returns(Transaction[] memory) {
        return recordMap[msg.sender];
    }

    // 排行榜系统
    function updateScore(uint _score) public {
        if (score[msg.sender] == 0) {
            userRanking.push(msg.sender);
        }

        score[msg.sender] = _score;
        mp();
    }

    // 冒泡排序
    function mp() internal {
        uint len = userRanking.length;
        for (uint i = 0; i < len - 1; i++) {
            for (uint j = 0; j < len -1 -i; j++) {
                if (score[userRanking[j]] > score[userRanking[i]]) {
                    address temp = userRanking[i];
                    userRanking[i] = userRanking[j];
                    userRanking[j] = temp;
                }
            }
        }
    }

    // 获取排行榜
    function getTopArr() public view returns(address[] memory) {
        return userRanking;
    }
}