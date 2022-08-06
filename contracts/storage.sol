// SPDX-License-Identifier:MIT
pragma solidity^0.8.15;

// Storage
// HDD
// ブロックチェーン上にデータが保存
// 書き換えに高いコストが必要
// 基本、関数外で使う
// グローバル変数に近い

// Memory
// RAM
// 関数実行時のみデータが使われ、チェーン上には保存されない
// コストやすい
// 基本、関数内で使う
// ローカル変数に近い

// Pure はStorageデータを使わない
// View はStorageデータを読むときにだけ


// string, struct, 配列　は memory / storage と書く必要がある（Document参照）（コンプレックスデータ）

contract MyContract1{
    // Storage .. 関数外で書いてるから
    uint public number = 123;
    string public message = "Hello World";

    function setString(string memory input)public{
        string memory newMessage = input; // memory
        message = newMessage;
    }

    function setNumber(uint input) public{
        uint newNumber = input; // memory
        number = newNumber;
    }
}

contract MyContract2{
    struct Kitty {
        string name;
        address owner;
    }

    Kitty[] public kitties;

    function newKitty(string memory _name) public{
        Kitty memory kitty = Kitty(_name, msg.sender);
        kitties.push(kitty);
    }

    // idを入れてnameを返す関数　→ storage と memory の２つ

    function sGetKitty(uint _id)public returns(string memory){
        // 関数内のStorageはポインタの役割【実行する上ではmemoryより安い！！！】
        Kitty storage kitty = kitties[_id];
        return kitty.name;
    }

    function mGetKitty(uint _id)public returns(string memory){
        Kitty memory kitty = kitties[_id];
        return kitty.name;
    }
    // nameを変える
    function sChangeKitty(uint _id, string memory _name) public{
        Kitty storage kitty = kitties[_id];
        kitty.name = _name;
    }

}