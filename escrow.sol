pragma solidity 0.8.0;

contract Escrow {

  address payable seller;
  address payable buyer;
  mapping(address=>uint) TotalAmount;

  enum State {
    pay,
    recieve,
    complete
  }

  State public state;

  constructor (address _buyer, address payable _seller) {
    buyer= _buyer;
    seller = _seller;
    state = State.pay;
  }

  function confirmPayment () external  onlyBuyer() checkState(State.pay) payable{
    state = State.recieve;
  }

  function deliver ()  onlyBuyer() checkState(State.recieve) external payable{
    seller.transfer (address(this).balance);
    state = State.complete;
  }

  modifier onlyBuyer() {
    require(msg.sender == buyer, "only buyer can call this function");
    _;
  }

  modifier checkState (State currstate) {
    require (currstate == state , "Cannot order" );
    _;
  }

}
