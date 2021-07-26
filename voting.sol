pragma solidity 0.8.0;

contract Voting {
  address[] public voters;
  uint public requirement ;
  
  constructor(address[] memory _voters, uint ) public {
      voters = _voters;
      requirement = requirement;
  }

  struct Vote {
      uint id;
      bytes32 proposal;
      address voter;
      bool voted;
  }

  struct Proposal {
    bytes32 proposal;
    bool votedYes;
  }

  uint public countYes = 0;
  Vote [] storage votes;
  Proposal [] storage proposals;

  function createProposal (bytes32 idea) public onlyVoter(){
    proposals.push(Proposal(idea, false));
  }

  function ActualVote (bytes32 proposal) public onlyVoter(){
    bool done= false;
    for(uint i = 0; i < votes.length; i++) {
        if(votes[i].voter == msg.sender) {
            done = true;
        }
    }
    require(done==false, "cannot vote twice!");
    votes.push(Vote(
      votes.length,
      proposal,
      msg.sender,
      true
    ));
    countYes+=1;

    if (countYes == requirement){
      proposals[0].votedYes==true;
    }
  }


  modifier onlyVoter (){
    bool allowed = false;
    for(uint i = 0; i < voters.length; i++) {
        if(voters[i] == msg.sender) {
            allowed = true;
        }
    }
    require(allowed == true, 'only approver allowed');
    _;
  }
}
