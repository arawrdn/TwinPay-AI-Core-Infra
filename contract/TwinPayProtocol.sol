// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title TwinPayAI_Core
 * @author Aradea Wisnu Wardana
 * @dev Optimized for Celo. Features: Soulbound Token, Daily AI Polls, and On-chain Feedback.
 */
contract TwinPayAI_Core {

    string public name = "TwinPay SBT";
    string public symbol = "TP-SBT";
    string public sbtImageURI = "https://ipfs.io/ipfs/QmTwinPayAI_SBT_Placeholder"; // Ganti dengan CID logo kamu
    address public owner;

    struct Poll {
        string question;
        string optionA;
        string optionB;
        uint256 votesA;
        uint256 votesB;
        uint256 deadline;
        bool exists;
    }

    struct Suggestion {
        address proposer;
        string text;
        uint256 timestamp;
    }

    uint256 public pollCount;
    mapping(uint256 => Poll) public polls;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    
    mapping(address => bool) public hasSBT;
    mapping(address => uint256) public userXP; 
    
    Suggestion[] public suggestions;
    mapping(address => uint256) public lastSuggestionTime;

    event SBTMinted(address indexed user);
    event Voted(uint256 indexed pollId, address indexed voter, bool votedA);
    event SuggestionSubmitted(address indexed proposer, string text);
    event PollCreated(uint256 pollId, string question);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    constructor() {
        owner = msg.sender;
        
        // Initial AI-themed Poll
        createPoll(
            "Will AI agents completely replace manual payments by 2030?", 
            "Highly Likely", 
            "No, human touch stays", 
            24
        );
    }

    // --- FEATURE: TWINPAY SBT ---
    function mintSBT() external {
        require(!hasSBT[msg.sender], "SBT already minted");
        hasSBT[msg.sender] = true;
        userXP[msg.sender] += 10;
        emit SBTMinted(msg.sender);
    }

    // Soulbound: Lock transfer
    function transfer(address, uint256) public pure {
        revert("TwinPay SBT is non-transferable");
    }

    // --- FEATURE: DAILY AI POLLS ---
    function createPoll(
        string memory _question, 
        string memory _a, 
        string memory _b, 
        uint256 _durationInHours
    ) public onlyOwner {
        pollCount++;
        polls[pollCount] = Poll({
            question: _question,
            optionA: _a,
            optionB: _b,
            votesA: 0,
            votesB: 0,
            deadline: block.timestamp + (_durationInHours * 1 hours),
            exists: true
        });
        emit PollCreated(pollCount, _question);
    }

    function castVote(uint256 _pollId, bool _voteForA) external {
        Poll storage poll = polls[_pollId];
        require(poll.exists, "Poll does not exist");
        require(block.timestamp <= poll.deadline, "Poll has ended");
        require(!hasVoted[_pollId][msg.sender], "Already voted");

        if (_voteForA) {
            poll.votesA++;
        } else {
            poll.votesB++;
        }

        hasVoted[_pollId][msg.sender] = true;
        userXP[msg.sender] += 5;
        
        emit Voted(_pollId, msg.sender, _voteForA);
    }

    // --- FEATURE: ON-CHAIN SUGGESTIONS ---
    function submitSuggestion(string memory _text) external {
        require(bytes(_text).length > 0, "Empty text");
        require(block.timestamp >= lastSuggestionTime[msg.sender] + 1 days, "Daily limit reached");

        suggestions.push(Suggestion({
            proposer: msg.sender,
            text: _text,
            timestamp: block.timestamp
        }));

        lastSuggestionTime[msg.sender] = block.timestamp;
        userXP[msg.sender] += 2;

        emit SuggestionSubmitted(msg.sender, _text);
    }

    function getPollResults(uint256 _pollId) external view returns (uint256 a, uint256 b) {
        return (polls[_pollId].votesA, polls[_pollId].votesB);
    }
}
