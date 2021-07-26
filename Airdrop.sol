pragma solidity 0.8.0;

contract TokenInterface {
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}

contract AirDrop{

  TokenInterface public dToken;

  constructor(address _dToken) {
    dToken = TokenInterface(_dToken);
  }

  function airdrop (
    address[] memory _recievers,
    uint[] memory _amounts
    )
  public
  {
    require ( _recievers.length == _amounts.length ,'equal arrays needed' );
    for (uint j=0, j< recievers.length ; j++){
      dToken.transfer(_recievers[j],_amounts[j]);
    }
  }

}
