// SPDX-License-Identifier:MIT
pragma solidity ^0.8.15;

contract HelloWorld{
    function hello(string memory message) public pure returns(string memory){
        return message;
    }
}