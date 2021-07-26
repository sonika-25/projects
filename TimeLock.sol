pragma solidity 0.8.0;

contract TimeLock {
  uint public end;
  constructor (uint _duration){
    end = _duration + block.timestamp;
  }

  function () external payable {}

  function TimeLocked(
      uint amount,
      address payable reciever
    )
    public
  {
    require (block.timestamp >= end, 'function is timelocked');
    uint256 amount = address(this).balance;
    require(amount > 0, "no ETH to release");
    reciever.transfer(amount);
  }

}
