// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract MyContract{
    // uint256
    int a = -5;
    // uint .. 符号なし
    uint b = 5;
    bool c = true;
    string d = 'hello world';
    // bytes32 .. 長さが32の文字列
    bytes32 e = 'ETH';
    address f = 0x0E7a85c3E7009B31c966B51721702f7F74513bac;
    // 小数点は無い！

    function add(uint x, uint y)public pure returns (uint){
        uint result;
        result = x + y;
        return result;
    }

    // 関数外の変数を参照しているから、pureではなくview
    function addToB(uint x)public view returns(uint result){
        result = x + b;
    }

    function changeB(uint x) public returns(uint){
        b = x;
        return b;
    }
}