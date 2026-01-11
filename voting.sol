pragma solidity ^0.8.0;

contract Voting {

    address public admin;
    bool public electionActive;

    struct Candidate {
        string name;
        uint voteCount;
    }

    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    constructor() {
        admin = msg.sender;
        electionActive = false;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    function addCandidate(string memory _name) public onlyAdmin {
        candidates.push(Candidate(_name, 0));
    }

    function startElection() public onlyAdmin {
        electionActive = true;
    }

    function endElection() public onlyAdmin {
        electionActive = false;
    }

    function vote(uint candidateIndex) public {
        require(electionActive, "Election is not active");
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");

        candidates[candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function getCandidatesCount() public view returns (uint) {
        return candidates.length;
    }
}
