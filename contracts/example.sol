// SPDX-License-Identifier:MIT
pragma solidity^0.8.15;

contract A{
    string public msgA = "hello A";

    constructor(string memory _msg){
        msgA = _msg;
    }

    // virtual .. 上書きされる関数
    function print() public virtual view returns(string memory){
        return msgA;
    }

    function helloA() public pure returns(string memory){
        return "Hello A";
    }
}

contract B {
    string public msgB = "hello B";

    constructor(string memory _msg){
        msgB = _msg;
    }

    function print() public virtual view returns(string memory){
        return msgB;
    }

    function helloB() public pure returns(string memory){
        return "Hello B";
    }
}

// A, Bの順番も呼び出し順に影響がある。
// 下だとAの方が先呼ばれるから、superはBの方がよばれる
// 後ろの方に上書きされる 
contract C is A, B{
    // constructorで変数の上書き
    constructor(string memory _msg) A(_msg) B("MessageB"){

    }

    // override .. 上書きする関数
    function print() public override(A,B) view returns(string memory){
        // return A.print();  // A
        return super.print(); // B
    }
    // 親の変数を変更。ただしPrivateの場合は不可
    function changeMsgB(string memory _msg)public{
        msgB = _msg;
    }
}
