// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "hardhat/console.sol";
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
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Withdrawal(uint amount, uint when);
    event AddedToWhitelist(address indexed account);
    event Crowdsale(address indexed from, address indexed to, uint256 value);
    mapping(address => uint) public customersBalance;
    mapping(address => bool) public whitelist;
    // A mapping is a key/value map. Here we store each account's balance.
    //freeze in crowdsale!
    mapping(address => uint256) balances;
    uint tokensTotal; //
    uint256 public totalStock; //value of TBNB

    constructor(uint _unlockTime) payable {
        name = "ZYtoken";
        symbol = "ZIT";
        decimals = 18;
        totalSupply = 10000 * (10 ** decimals);
        owner = payable(msg.sender);
        customersBalance[msg.sender] = totalSupply;
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime;
        tokensTotal = 10000;
    }

    uint256 public startline = 1678204800;
    uint256 public deadline = 1678777415;

    function buyTokens() public payable {
        //yushou

        require(block.timestamp <= startline, "Crowdsale not started yet ");
        //require(x < 100, string(abi.encodePacked("x must be less than 100, but got ", x)));
        require(block.timestamp <= deadline, "Crowdsale has ended");
        require(
            whitelist[msg.sender],
            "Only whitelisted users can purchase tokens"
        );

        totalStock += msg.value;
        customersBalance[msg.sender] += msg.value;
        owner.transfer(msg.value);
    }

    function addWhitelist(address user) public {
        require(
            msg.sender == owner,
            "Only contract owner can add to whitelist"
        );
        // valid
        require(whitelist[user] == true, "Already added this address");
        emit AddedToWhitelist(user);
        whitelist[user] = true;
    }

    function checkInWhitelist(address _address) public view returns (bool) {
        // valid
        if (whitelist[_address] == true) {
            return true;
        } else {
            return false;
        }
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    function Claim(address payable user) public payable {
        require(
            whitelist[msg.sender],
            "Only contract owner can add to whitelist"
        );
        require(customersBalance[msg.sender] > 0, "Already transferred");
        uint forTotal = (customersBalance[msg.sender] / totalStock) *
            tokensTotal;

        user.transfer(forTotal);
        customersBalance[owner] -= forTotal;
        delete (customersBalance[msg.sender]);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function transfer(address to, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Not enough tokens");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }

    function withdraw() public {
        // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
         console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");

        emit Withdrawal(address(this).balance, block.timestamp);

        owner.transfer(address(this).balance);
    }
}
