// SPDX-License-Identifier:MIT
pragma solidity ^0.8.15;

contract Array1{
    uint [] numbers = [1,2,3,4,5];

    function getNumbers() public view returns(uint[] memory){
        return numbers;
    }

    function getNumberLength() public view returns(uint){
        return numbers.length;
    }
    
    function addNumber(uint _number) public {
        numbers.push(_number);
    }

    function popNUmber() public{
        numbers.pop();
    }

}
contract Array2{
    uint [6] numbers  =[1,2,3,4,5];

    function getNumbers() public view returns(uint[6] memory){
        return numbers;
    }

    function modifyNumber(uint _index, uint _number)public{
        numbers[_index] = _number;
    }
}

contract Mapping{
    mapping(address => uint)balance;

    function addBalance(uint _toAdd) public returns(uint){
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }

    function getBalance(address _address) public view returns(uint){
        return balance[_address];
    }
}
