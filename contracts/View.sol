//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract View{
    address owner;
    uint256 result;
   
    constructor(){
       owner = msg.sender;
    }
        
    function viewOwner()public view returns(address){
        return owner;
    }

    function multiplyTwoNumbers(uint256 _numOne, uint256 _numTwo)public{
        result = _numOne * _numTwo;
    } 

    function seeResult()public view returns(uint256){
        return result;
    }
}