// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Lock {
    uint public unlockTime;
    address payable public owner;

    event Withdrawal(uint amount, uint when);

    constructor(uint _unlockTime) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

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


contract MyCrowdsale {
    uint public startTime;
    uint public endTime;
    address public wallet; // 存储卖出代币后应该支付给的地址
    uint public rate; // 记录买卖代币的汇率
    uint public weiRaised; // 记录收到的Wei（以太币）

    MyToken public token; // 引用MyToken代币合同

    constructor(
        uint _startTime, // Crowdsale开始时间
        uint _endTime, // Crowdsale结束时间
        uint _rate, // 买卖代币的汇率
        address payable _wallet // 指定收款地址
    )
        public
    {
        require(_startTime >= now, "Crowdsale has already started");
        require(_endTime >= _startTime, "Crowdsale end time must be later than start time");
        require(_rate > 0, "Rate must be greater than zero");
        require(_wallet != address(0), "Invalid wallet address");

        startTime = _startTime;
        endTime = _endTime;
        rate = _rate;
        wallet = _wallet;
        token = new MyToken(); // 创建代币合同
    }

    function() external payable {
        buyTokens(msg.sender);
    }

    function buyTokens(address _beneficiary) public payable {
        require(_beneficiary != address(0), "Invalid beneficiary address");
        require(msg.value != 0, "Wei amount cannot be zero");
        require(now >= startTime && now <= endTime, "Crowdsale outside of time range");

        uint256 weiAmount = msg.value;

        // 计算出卖出的代币数量，注意需要考虑小数点的精度
        uint256 tokens = weiAmount * rate / 1 ether;
        weiRaised += weiAmount;

        require(token.transfer(_beneficiary, tokens), "Token transfer failed");

        // 转账到钱包地址
        wallet.transfer(msg.value);
    }
}