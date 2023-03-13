// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
//import "./MyFirstLaunchPad.sol";

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
        symbol = "VRA";
        decimals = 18;
        totalSupply = 10000 * (10 ** decimals);
        balanceOf[msg.sender] = totalSupply;
        unlockTime = _unlockTime;
        owner = payable(msg.sender);
        owner = payable(msg.sender);
        //example
        whitelist[0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c] = true;
        tokensTotal = 10000;
    }

    mapping(address => bool) public whitelist;
    uint256 public startline = 1678204800;
    uint256 public deadline = 1678777415;
    uint public tokensTotal;

    mapping(address => uint) public customersQuota;
    uint256 public totalStock;

    function buyTokens() public payable {
        //yushou

        require(block.timestamp <= startline, "Crowdsale not started yet ");
        require(block.timestamp <= deadline, "Crowdsale has ended");
        require(
            whitelist[msg.sender],
            "Only whitelisted users can purchase tokens"
        );

        totalStock += msg.value;
        customersQuota[msg.sender] += msg.value;
        owner.transfer(msg.value);
    }

    function addWhitelist(address user) public {
        require(
            msg.sender == owner,
            "Only contract owner can add to whitelist"
        );
        // valid
        require(whitelist[user] == true, "Invalid address");
        whitelist[user] = true;
    }

    //     function getWhitelist() public {
    //     require(msg.sender == owner, "Only contract owner lookup whitelist");
    //     // valid
    //     console.log();
    // }

    function Claim(address payable user) public {
        require(
            whitelist[msg.sender],
            "Only contract owner can add to whitelist"
        );
        uint forTotal = (customersQuota[user] / totalStock) * 10000;
        user.transfer(forTotal);
    }

    function buy() public payable {
        require(msg.value > 0, "Payment amount must be greater than 0.");
        uint256 amount = msg.value;
        owner.transfer(amount);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
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
