// SPDX-License-Identifier: MIT
//
//  ________  ___  ________   _______   _____ ______   ________  _________  ___  ________     
// |\   ____\|\  \|\   ___  \|\  ___ \ |\   _ \  _   \|\   __  \|\___   ___\\  \|\   ____\    
// \ \  \___|\ \  \ \  \\ \  \ \   __/|\ \  \\\__\ \  \ \  \|\  \|___ \  \_\ \  \ \  \___|    
//  \ \  \    \ \  \ \  \\ \  \ \  \_|/_\ \  \\|__| \  \ \   __  \   \ \  \ \ \  \ \  \       
//   \ \  \____\ \  \ \  \\ \  \ \  \_|\ \ \  \    \ \  \ \  \ \  \   \ \  \ \ \  \ \  \____  
//    \ \_______\ \__\ \__\\ \__\ \_______\ \__\    \ \__\ \__\ \__\   \ \__\ \ \__\ \_______\
//     \|_______|\|__|\|__| \|__|\|_______|\|__|     \|__|\|__|\|__|    \|__|  \|__|\|_______|                                                                        
//       www.cinematiclabs.xyz/taiko/trail
//
//
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address public owner;
    uint256 public cost;
    uint256 public claim;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _cost,
        uint256 _claim
    ) ERC721(_name, _symbol) {
        owner = msg.sender;
        cost = _cost;
        claim = _claim;
    }

    mapping(address => bool) public isMinted;
    mapping(address => bool) public isStarted;
    mapping(address => bool) public isAgreed;
    mapping(address => bool) public isTicket;
    mapping(address => bool) public isClaimTaikoAirdrop;
    mapping(address => bool) public isClaimTaikoBalance;
    mapping(address => bool) public isClaimCinematic;
    mapping(address => bool) public isClaimFarcaster;
    mapping(address => bool) public isClaimTaikoons;
    mapping(address => bool) public isClaimEthBalance;
    mapping(address => bool) public isClaimTx;
    
    function mint(string memory tokenURI) public payable {
        require(msg.value >= cost);
        require(isStarted[msg.sender], "Taiko Trail not started for this address");
        require(isAgreed[msg.sender], "Agreement not confirmed for this address");
        require(isTicket[msg.sender], "Ticket not confirmed for this address");

        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        isMinted[msg.sender] = true;
    }

    function start() public payable {
        require(msg.value >= claim);
        isStarted[msg.sender] = true;
    }

    function agree() public payable {
        require(msg.value >= claim);
        isAgreed[msg.sender] = true;
    }

    function ticket() public payable {
        require(msg.value >= claim);
        isTicket[msg.sender] = true;
    }

    function claimTaikoAirdrop() public payable {
        require(msg.value >= claim);
        isClaimTaikoAirdrop[msg.sender] = true;
    }

    function claimTaikoBalance() public payable {
        require(msg.value >= claim);
        isClaimTaikoBalance[msg.sender] = true;
    }

    function claimCinematic() public payable {
        require(msg.value >= claim);
        isClaimCinematic[msg.sender] = true;
    }

    function claimFarcaster() public payable {
        require(msg.value >= claim);
        isClaimFarcaster[msg.sender] = true;
    }

    function claimTaikoons() public payable {
        require(msg.value >= claim);
        isClaimTaikoons[msg.sender] = true;
    }

    function claimEthBalance() public payable {
        require(msg.value >= claim);
        isClaimEthBalance[msg.sender] = true;
    }

    function claimTx() public payable {
        require(msg.value >= claim);
        isClaimTx[msg.sender] = true;
    }

    function totalSupply() public view returns (uint256) {
        return _tokenIds.current();
    }

    function withdraw() public {
        require(msg.sender == owner);
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success);
    }
}