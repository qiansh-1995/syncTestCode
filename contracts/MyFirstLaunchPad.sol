// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.9;

// // Uncomment this line to use console.log
// // import "hardhat/console.sol";
// import "./Lock.sol";

// contract MyFirstLaunchPad  {
//     // (用户存入的TBNB)➗(总存入的TBNB) * 10000
//     mapping(address => bool) public whitelist;
//     uint256 public startline = 1678204800; 
//     uint256 public deadline = 1840905600; 
//     uint public tokensTotal;

//     mapping(address =>uint) public  customersQuota;
//     uint256 public totalStock;
//     address payable owner;
//     constructor() {
//         // add test address
//         owner = payable(msg.sender);
//         whitelist[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = true;
//         whitelist[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2] = true;
//         whitelist[0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c] = true;
//         tokensTotal = 10000;
//     }
    
//     function buyTokens() public payable {
//         //yushou
        
//         require(block.timestamp <= startline, "Crowdsale not started yet ");
//         require(block.timestamp <= deadline, "Crowdsale has ended");
//         require(whitelist[msg.sender], "Only whitelisted users can purchase tokens");
        
//         totalStock += msg.value;
//         customersQuota[msg.sender]+=msg.value;
//         uint expectValue =msg.value/totalStock *10000;
//         owner.transfer(msg.value);

         
//     }
    
//     function addWhitelist(address user) public {
//         require(msg.sender == owner, "Only contract owner can add to whitelist");
//         // valid
//         require(whitelist[user]==true,"Invalid address");
//         whitelist[user] = true;
//     }
//     //     function getWhitelist() public {
//     //     require(msg.sender == owner, "Only contract owner lookup whitelist");
//     //     // valid
//     //     console.log();
//     // }
    
//     function Claim( address payable user ) public {
//             require(whitelist[msg.sender], "Only contract owner can add to whitelist");
//             uint forTotal= customersQuota[user]/totalStock *10000;
//             user.transfer(forTotal);
//     }
// }
