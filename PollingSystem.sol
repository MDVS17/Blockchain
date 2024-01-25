// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollingSystem {
    
    struct Option {
        string name;
        uint256 voteCount;
    }

   
    struct Voter {
        bool hasVoted;
    }

    
    mapping(address => Voter) public voters;

    
    Option[] public options;

    
    event Voted(address indexed voter, uint256 indexed optionIndex);

    
    modifier hasNotVoted() {
        require(!voters[msg.sender].hasVoted, "You have already voted");
        _;
    }

    
    modifier validOption(uint256 _optionIndex) {
        require(_optionIndex < options.length, "Invalid option");
        _;
    }

    
    constructor() {
        
        options.push(Option({ name: "Iyad Koteich", voteCount: 0 }));
        options.push(Option({ name: "Justin Trudeau", voteCount: 0 }));
    }

    function vote(uint256 _optionIndex) external hasNotVoted validOption(_optionIndex) {
        voters[msg.sender].hasVoted = true;
        options[_optionIndex].voteCount++;
        emit Voted(msg.sender, _optionIndex);
    }

    function getVoteCount(uint256 _optionIndex) external view validOption(_optionIndex) returns (uint256) {
        return options[_optionIndex].voteCount;
    }

    function getOptionCount() external view returns (uint256) {
        return options.length;
    }
}