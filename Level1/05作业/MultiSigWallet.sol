// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

// 多签钱包的功能: 合约有多个 owner，一笔交易发出后，需要多个 owner 确认，确认数达到最低要求数之后，才可以真正的执行。
contract MultiSigWallet {
    address[] private owner;
    mapping (address=>bool) private isOwner;
    mapping (uint=>mapping (address=>bool)) private _approved;
    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool exected;
    }
    Transaction[] private _transaction;

    event ReceiveEvent(address addr, uint value);
    event FallbackEvent(address addr, uint value);
    event SubmitEvent(uint len);
    event ApprovEvent(uint txId, address addr, bool res);
    event ExecuteEvent(uint txId,  bool res);
    event RevokeEvent(uint txId, address addr, bool res);

    modifier onlyOwner() {
        require(isOwner[msg.sender], 'not owner');
        _;
    }

    modifier txExists(uint txId) {
        require(txId <= _transaction.length - 1, "tx doesn't exist");
        _;
    }

    modifier notApproved(uint txId) {
        require(!_approved[txId][msg.sender], "tx already approved");
        _;
    }

    modifier notExecuted(uint txId) {
        require(_transaction[txId].exected, "tx is exected");
        _;
    }

    constructor(address[] memory _owner, uint _required) {
        require(_required > 0 && _required <= _owner.length, 'invalid required number of owners');
        for (uint i = 0; i < _owner.length; i++) {
            address ownerItem = _owner[i];
            require(ownerItem != address(0), "invalid owner");
            require(!isOwner[ownerItem], "owner is not unique");
            isOwner[ownerItem] = true;
            // owner[i] = ownerItem;
            owner.push(ownerItem);
        }
    }

    receive() external payable {
        emit ReceiveEvent(msg.sender, msg.value);
    }

    fallback() external payable {
        emit FallbackEvent(msg.sender, msg.value);
    }

    function submit(address _to, uint _value, bytes memory _data, bool _exected ) public {
        Transaction memory _t = Transaction({
            to: _to,
            value: _value,
            data: _data,
            exected: _exected
        });
        _transaction.push(_t);
        emit SubmitEvent(_transaction.length);
    }

    function approv(uint txId) external onlyOwner txExists(txId) notApproved(txId) notExecuted(txId)  {
        _approved[txId][msg.sender] = true;
        emit ApprovEvent(txId, msg.sender, true);
    }

     function execute(uint txId) external onlyOwner txExists(txId) notApproved(txId) notExecuted(txId)  {
        uint approvCount = getApprovalCount(txId);
        require(approvCount >= owner.length, "approvals < required");
        Transaction memory _t = _transaction[txId];
        _t.exected = true;
        (bool success,) = _t.to.call{value: _t.value}(_t.data);
        emit ExecuteEvent(txId, success);
    }

    function getApprovalCount(uint txId) internal view returns(uint) {
        uint count;
        for (uint i = 0; i < owner.length; i++) {
            if (_approved[txId][owner[i]]) {
                count += 1;
            }
        }

        return count;
    }

    function revoke(uint txId) external onlyOwner txExists(txId) notExecuted(txId) {
        require(_approved[txId][msg.sender], 'tx not approved');
        _approved[txId][msg.sender] = false;
        emit RevokeEvent(txId, msg.sender, false);
    }
}