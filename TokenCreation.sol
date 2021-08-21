//"SPDX-License-Identifier:UNLICENSED"

pragma solidity ^0.8.0;

/*
Create a token based on ERC20 which is buyable. Following features should present;

1. Anyone can get the token by paying against ether
2. Add fallback payable method to Issue token based on Ether received. Say 1 Ether = 100 tokens.
3. There should be an additional method to adjust the price that allows the owner to adjust the price.
*/

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';

// ==========================================================================================================

contract myToken is ERC20{

    address public owner;
    uint private rate;
    
    constructor() ERC20("DADDU", "DDU"){
        _mint(msg.sender, 1000000 * 10 ** 18);
        rate = 100;
        owner = msg.sender;
    }
    
    modifier onlyOwner {
      require( msg.sender == owner, "Only Owner can change the Price");
      _;
  }
  
      modifier etherValue {
      require( msg.value > 0);
      _;
  }
  
  // _________________ Task 1 ____________________
  function getTokens() payable external {
    _mint(msg.sender, msg.value * rate * 10 ** 18);
      
  }
  
  
  // _________________ Task 2 ____________________
  
  fallback() external payable etherValue(){
      _mint(msg.sender, msg.value * rate * 10 ** 18);
  }

   receive() external payable{
    }
    
    
    // _________________ Task 3 ____________________
    function changePrice(uint _rate) external onlyOwner{
    rate = _rate;
      
  }
}