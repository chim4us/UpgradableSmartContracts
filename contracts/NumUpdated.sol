pragma solidity >=0.4.22 <0.9.0;

import "./Storage.sol";

contract NumUpdated is Storage{
  modifier onlyowner(){
    require(msg.sender == owner);
    _;
  }

  constructor() public{
    Initialized(msg.sender);
  }

  function Initialized(address _initialize) public{
    require(!_initialized);
    _initialized = true;
    owner = _initialize;
  }

  function getNum() public view returns(uint){
    return _uintStorage["Num"];
  }

  function setNum(uint _newNum) public onlyowner{
    _uintStorage["Num"] = _newNum;
  }
}
