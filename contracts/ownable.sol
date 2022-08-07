// SPDX-License-Identifier:MIT
pragma solidity^0.8.15;

// 継承
contract Ownable{
    address owner;
    // アクセスできるOwnerを限定
    modifier onlyOwner {
        require(msg.sender == owner, "You Are Not Owner");
        _;
    }
    // ContractをDeployするときに実行される
    constructor(){
        owner = msg.sender;
    }
}