// SPDX-License-Identifier:MIT
pragma solidity^0.8.15;

import "./ownable.sol";

// SimpleBankの方は誰でも別の人がDepositしたものでもWithDrawできる！！
contract SimpleBank{
    // このContractに入金するDeposit関数
    // payable .. このContractに入金できるようにする
    function deposit()public payable{

    }
    // このContractに出勤するWithdraw関数
    function withdraw()public{
        // msg.senderにtransferする
        // payableをつけて価値があるものを送金する
        // address(this).balance .. 残高
        // transferは非推奨？　callに移動？
        payable(msg.sender).transfer(address(this).balance);
    }
}

// 誰がいくら入金したかを記録
contract Bank is Ownable{

    // indexed .. フィルタリング（３つまで）
    event balanceUpdate(string _txType, address indexed _owner, uint _amount);

    mapping(address => uint) balance;

    modifier balanceCheck(uint _amount){
        require(balance[msg.sender] >= _amount);    
        _;
    }
    
    function getBalance() external view returns(uint){
        return balance[msg.sender];
    }

    function deposit() external payable onlyOwner{
        // msg.value どれくらい送ったか
        balance[msg.sender] += msg.value;

        emit balanceUpdate("Deposit", msg.sender, balance[msg.sender]);
    }

    function withdraw(uint _amount) external {
        uint beforeWithdraw = balance[msg.sender];
        balance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        uint afterWithdraw = balance[msg.sender];
        assert(afterWithdraw == beforeWithdraw - _amount);

        emit balanceUpdate("Withdraw", msg.sender, balance[msg.sender]);
    }

    // Bank Contract内で送金できる関数
    function transfer(address _to, uint _amount) public onlyOwner balanceCheck(_amount){
        require(msg.sender != _to, "Insufficient Recipient");
        _transfer(msg.sender, _to, _amount);

        emit balanceUpdate("OutGoing Trasfer", msg.sender, balance[msg.sender]);
        emit balanceUpdate("InComing Transfer", _to, balance[_to]);
    }

    // _ で始まるのはPrivate関数
    // Mintするときによく使われる
    function _transfer(address _from, address _to, uint _amount) private {
        balance[_from] -= _amount;
        balance[_to] += _amount;
    }

    // NFTMarketで使う
    function transferFrom(address _from, address _to, uint _amount)external{
        require(balance[_from] >= _amount, "Insufficient balance");
        require(_from != _to, "Invalid Recepient");
        balance[_from] -= _amount;
        balance[_to] += _amount;

        emit balanceUpdate("OutGoing Transfer", _from, balance[_from]);
        emit balanceUpdate("InComing Transfer", _to, balance[_to]);

    }
}