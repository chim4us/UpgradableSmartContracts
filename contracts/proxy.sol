pragma solidity >=0.4.22 <0.9.0;

import "./Storage.sol";

contract proxy is Storage{
  address currentAddress;

  constructor(address _currenctAddr) public{
    currentAddress = _currenctAddr;
  }

  function upgrade(address newAddress)public{
    currentAddress = newAddress;
  }

  function() payable external {
    address implementation = currentAddress;
    require(currentAddress != address(0));
    bytes memory data = msg.data;

    assembly{
      let result := delegatecall(gas,implementation,add(data,0x20),mload(data),0,0)
      let size := returndatasize
      let ptr := mload(0x40)
      returndatacopy(ptr,0,size)
      switch result
      case 0 {revert(ptr,size)}
      default {return(ptr,size)}
    }
  }
}
