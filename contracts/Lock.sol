// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "./MyFirstLaunchPad.sol";
// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Lock {
    uint public unlockTime;
    address payable public owner;
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply;
    event Withdrawal(uint amount, uint when);
    mapping(address => uint256) public balanceOf;
    constructor(uint _unlockTime) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );
        name = "Vtoken";
        symbol = "VRG";
        decimals = 18;
        totalSupply = 10000 * (10 ** decimals);
        balanceOf[msg.sender] = totalSupply; 
        unlockTime = _unlockTime;
        owner = payable(msg.sender);

    }

    function withdraw() public {
        // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");

        emit Withdrawal(address(this).balance, block.timestamp);

        owner.transfer(address(this).balance);
        
    }
}


