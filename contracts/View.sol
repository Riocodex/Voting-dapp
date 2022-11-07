//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract View{
    address owner;
    constructor(){
        owner = msg.sender;
    }
        
    function viewOwner()public view returns(address){
        return owner;
    }
}