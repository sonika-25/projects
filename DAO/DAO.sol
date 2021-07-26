pragma solidity 0.7.3;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract Dao {
  IERC20 public token;
  enum Side {
    Yes,
    No
  }
  enum Status {
    Pending,
    Approved,
    Rejected
  }
  struct Proposal {
    address author;
    bytes32 hash;
    uint createAt;
    uint votesYes;
    uint VotesNo;
    Status status;
  }
  mapping(bytes32 => Proposal) public proposals;
  mapping(address => mapping (bytes32 => bool)) public votes;
  mapping (address => uint) public shares;
  uint public totalShares;
  uint constant CREATE_PROPOSAL_MIN_SHARE = 1000 * 10 ** 18;
  uint constant VOTING_PERIOD = 7 days;

  constructor (address _token){
    token = IERC20(token);
  }

  function deposit(uint amount) {
    shares[msg.sender] += amount;
    totalShares += amount;
    token.transferFrom(msg.sender, address(this), amount);
  }

  function withdraw (uint amount) {
    require (shares[msg.sender]>=amount, 'not enough shares');
    shares[msg.sender] -= amount;
    totalShares -= amount;
    token.transfer(msg.sender, amount);
  }
  
  function createProposal(
    bytes32 propposalHash
    ) public
  {
    require(shares(msg.sender)>= CREATE_PROPOSAL_MIN_SHARE, "not enough shares" );
    require (proposals(propposalHash).hash == bytes32(0), "propsal exists");
    proposals[propposalHash] = Proposal(
        msg.sender,
        propposalHash,
        block.timestamp,
        0,
        0,
        Status.Pending
    );
  }

  function vote (bytes32 pHash, Side side) external {
    Propsal public propsal = proposals(pHash);
    require (proposal.hash != bytes32(0), "propsal does not exist");
    require (proposal.status != Status.Pending, "propsal sent");
    require(block.timestamp <= propsal.createdAt + VOTING_PERIOD, "voting period over");
    require(votes[msg.sender][pHash] == false, 'cannot vote more than once');
    votes[msg.sender][pHash] = true;

    if (side == Side.Yes) {
      proposal.votesYes+=shares[msg.sender];
      if (proposals.votesYes * 100 / totalShares > 50){
        proposal.status = Status.Approved;
      }
    }

    if (side == Side.No) {
      proposal.votesNo+=shares[msg.sender];
      if (proposals.votesNo * 100 / totalShares > 50){
        proposal.status = Status.Rejected;
      }
    }
  }


}
