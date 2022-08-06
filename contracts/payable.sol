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
    
    function getBalance() public view returns(uint){
        return balance[msg.sender];
    }

    function deposit() public payable{
        // msg.value どれくらい送ったか
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public{
        balance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    // Bank Contract内で送金できる関数
    function transfer(address _to, uint _amount) public{
        balance[msg.sender] -= _amount;
        balance[_to] += _amount;
    }
}