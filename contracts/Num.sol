pragma solidity >=0.4.22 <0.9.0;

import "./Storage.sol";

contract NumFun is Storage{
  modifier onlyowner(){
    require(msg.sender == owner);
    _;
  }

  constructor() public{
    owner = msg.sender;
  }

  function getNum() public view returns(uint){
    return _uintStorage["Num"];
  }

  function setNum(uint _newNum) public{
    _uintStorage["Num"] = _newNum;
  }
}
