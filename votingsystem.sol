//SPDX-License-Identifier: MIT
 pragma solidity ^0.8.26;


// Base Contract
contract Ownable{
    address public owner;
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
         require(owner == msg.sender);
         _;
    }
}


// derived contract

contract VotingSystem is Ownable{
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

mapping(uint=>Candidate) public candidates;
mapping(address=>bool) public voters;
uint public totalCandidates;


function addCandidate(string calldata name) public onlyOwner{
    candidates[totalCandidates] = Candidate(totalCandidates, name, 0);
    totalCandidates++;
}

function vote(uint candidateId) public{
    require(!voters[msg.sender], "Already voted");
    require(candidateId < totalCandidates,"Invalid Candidate Id");

    voters[msg.sender] = true;
    candidates[candidateId].voteCount++;
}


function getCandidate(uint candidateId) external view returns (string memory name, uint voteCount){
        require(candidateId < totalCandidates,"Invalid Candidate Id");
        Candidate storage candidate = candidates[candidateId];
        return (candidate.name , candidate.voteCount);

}
function getTotalCandidates() public view returns (uint) {
    return totalCandidates;
}
}
