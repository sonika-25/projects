pragma solidity 0.7.3;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract TokenOpenZeppelin1 is ERC20 {
  constructor() ERC20('Token Name', 'TOKEN_SYMBOL') public {}
}

contract TokenOpenZeppelin2 is ERC20 {
  constructor() ERC20('Token Name', 'TOKEN_SYMBOL') public {
    _mint(msg.sender,100000);
  }
}

contract TokenOpenZeppelin3 is ERC20 {
  address public admin;
  constructor() ERC20('Token Name', 'TOKEN_SYMBOL') public {
    admin = msg.sender;
  }

  function mint(address to, uint amount) external{
    require(msg.sender==admin , 'Only admin');
    _mint(to,amounr);
  }
}

contract TokenOpenZeppelin4 is ERC20 {
  constructor() ERC20('Token Name', 'TOKEN_SYMBOL') public {}

  function faucet(address to, uint amount) external {
    _mint(to, amount);
  }
}
