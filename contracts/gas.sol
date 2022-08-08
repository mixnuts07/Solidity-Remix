// SPDX-License-Identifier:MIT
pragma solidity^0.8.15;

contract GasTest1{
    function compute(uint x, uint y) external returns(uint){
        uint result;
        for(uint i=0; i < y; i++){
            result += x;
        }
        return result;
    }

    function computeFree(uint x, uint y) pure external returns(uint){
        uint result;
        for(uint i=0; i < y; i++){
            result += x;
        }
        return result;
    }
}

contract GasTest2{
    uint a = 1;
    uint b = 2;
    uint c;     // たかい
    uint d = 1; // やすい

    function getA() view external returns(uint){
        return a;
    }
    function changeC() external returns(uint){
        c = a + b;
        return c;
    }
    // changeC よりやすい！
    function changeD() external returns(uint){
        d = a + b;
        return d;
    }
}

contract GasTest3{
    uint i;
    function forever() external returns(uint){
        while(true){
            i++;
        }
        return i;
    }
}