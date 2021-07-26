pragma solidity 0.8.0;

contract MultiSend {
  address public admin;
  uint public totalValue;

  constructor (address _admin){
    admin = _admin;
    totalvalue = msg.value;
  }

  function changeAdmin (address newAdmin) public onlyAdmin(){
    admin = newAdmin;
  }

  function getOwner() external view returns (address) {
      return owner;
  }

  function recharge () public onlyAdmin() {
    totalValue+=msg.value;
  }

  function addAmounts (uint[] amts) internal returns (uint) {
    uint totalamt = 0;
    for (uint i =0 ; i<amts.length; i++){
      totalamt+=amts[i];
    }
    return totalamt;
  }

  function singleSend (address payable employee, uint salary) public onlyAdmin() {
    require(totalValue >= salary, "insufficient funds: please recharge");
    withdraw( employee, salary );
  }

  function multiSend(address payable[] memory employees, uint[] memory salaries) payable public onlyAdmin() {
    require(employees.length == salaries.length, "Arrays need to be similar");
    uint totalAmt = addAmounts(amounts);
    require(totalValue>=totalAmt, "insufficient funds, needs to be recharged");

    for(uint i =0 ;i<employees.length ; i++){
      withdraw(employees[i],salaries[i]);
    }
  }

  modifier onlyAdmin() {
    require(msg.sender== admin, 'only admin');
    _;
  }
}
