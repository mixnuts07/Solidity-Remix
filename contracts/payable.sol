// SPDX-License-Identifier:MIT
pragma solidity^0.8.15;

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
contract Bank{
    mapping(address => uint) balance;
    address owner;

    // アクセスできるOwnerを限定
    modifier onlyOwner {
        require(msg.sender == owner, "You Are Not Owner");
        _;
    }

    modifier balanceCheck(uint _amount){
        require(balance[msg.sender] >= _amount, 'Insufficient Balance');
        _;
    }

    // ContractをDeployするときに実行される
    constructor(){
        owner = msg.sender;
    }

    function getBalance() public view returns(uint){
        return balance[msg.sender];
    }

    function deposit() public payable onlyOwner{
        // msg.value どれくらい送ったか
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public balanceCheck(_amount){
        uint beforeWithdraw = balance[msg.sender];
        balance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        uint afterWithdraw = balance[msg.sender];
        assert(afterWithdraw == beforeWithdraw - _amount);
    }

    // Bank Contract内で送金できる関数
    function transfer(address _to, uint _amount) public onlyOwner balanceCheck(_amount){
        require(msg.sender != _to, "Insufficient Recipient");
        balance[msg.sender] -= _amount;
        balance[_to] += _amount;
    }
}