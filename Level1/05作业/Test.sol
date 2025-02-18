// SPDX-License-Identifier: SEE LICENSE IN LICENSE
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

contract MyToken is IERC20 {
    string public name = "MyToken";
    string public symbol = "MTK";
    uint private decimals = 18;
    uint private _totalSupply;
    mapping(address => uint) private _balances;
    mapping (address => mapping (address => uint)) private _allowances;
    enum Status {
        normal,
        pause
    }
    Status private _contractStatus;
    mapping (address=>mapping (string=>bool)) ownable;

    constructor(uint amount) {
        _totalSupply = amount * 10 ** decimals;
        _balances[msg.sender] = _totalSupply;
        _contractStatus = Status.normal;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() public override view returns(uint) {
        return _totalSupply;
    }

    function balanceOf(address account) public override view returns(uint) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(_contractStatus == Status.normal, 'bu neng jiao yi');
        require(_balances[msg.sender] >= amount, 'ERC20: transfer amount exceeds balance');
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        // payable(recipient).transfer(amount);
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

     function allowance(address owner, address spender) public view override returns (uint256){
        return _allowances[owner][spender];
     }

     function approve(address spender, uint256 amount) public override returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
     }

     function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(_contractStatus == Status.normal, 'bu neng jiao yi');
        require(_balances[sender] >= amount, "ERC20: transfer amount exceeds balance");
        require(_allowances[sender][recipient] >= amount, "ERC20: transfer amount exceeds allowance");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        _allowances[sender][recipient] -= amount;
        emit Transfer(sender, recipient, amount); 
        return true;
     }

     function toNormal() public returns(bool) {
        _contractStatus = Status.normal;
        return true;
     }

     function toPause() public returns(bool) {
        _contractStatus = Status.pause;
        return true;
     }

     function userDestoryToken() public {
        require(_balances[msg.sender] > 0, "ERC20: transfer amount exceeds balance");
        _balances[msg.sender] = 0;
     }


}

/**
 * Minting：允许合约所有者创建新的代币。
    Burning：允许用户销毁代币。
    Pausable：允许合约在紧急情况下暂停所有转账。
    Ownable：添加合约所有者权限，限制某些功能只能由所有者调用。
 */
