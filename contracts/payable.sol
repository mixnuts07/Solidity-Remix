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
        payable(msg.sender).transfer(address(this).balance);
    }
}