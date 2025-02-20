pragma solidity 0.8.20;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract MyTokenErc20 is IERC20 {
    string public name = "MyTokenErc20";
    string public symbol = 'MTK';
    uint public decimals = 18;
    uint private totalNum;
    mapping (address => uint) private _balances;
    mapping (address=>mapping (address=>uint)) private _approves;
    address private owner;
    enum Status {
        success,
        pause
    }
    Status status;

    constructor(uint _totalNum) {
        totalNum = _totalNum * 10 ** decimals;
        _balances[msg.sender] = totalNum;
        owner = msg.sender;
        status = Status.success;
    }

    function totalSupply() external view returns (uint256) {
        return totalNum;
    }

    function balanceOf(address account) external view returns (uint256){
        require(account != address(0), 'account no');
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external pauseTrans returns (bool) {
        require(_balances[msg.sender] >= amount, 'amount no money');
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external pauseTrans returns (bool) {
        require(_balances[sender] >= amount, 'amount no money');
        require(_approves[sender][recipient] >= amount, 'amount no money');
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        _approves[sender][recipient] -= amount;
        return true;
    }

    function allowance(address _owner, address spender) external view returns (uint256) {
        return _approves[_owner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _approves[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    modifier isOwner() {
        require(msg.sender == owner, 'you no owner');
        _;
    }

    modifier pauseTrans() {
        require(status == Status.success, 'status is pause');
        _;
    }

    function minting(uint amount) external isOwner returns(bool) {
        uint addNum = amount * 10 ** decimals;
        totalNum += addNum;
        _balances[msg.sender] += addNum;
        return true;
    }

    function burning() external returns(bool) {
        require(_balances[msg.sender] != 0, 'user balance is zero');
        uint num = _balances[msg.sender];
        totalNum -= num;
        _balances[msg.sender] = 0;
        _balances[owner] -= num;

        return true;
    }
}