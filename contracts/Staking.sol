// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Staking {
    mapping(address => uint256) public stakes;
    uint256 public totalStaked;
    uint256 public rewardPerEth = 1e16; // 0.01 ETH reward per 1 ETH staked (demo)

    function stake() external payable {
        require(msg.value > 0, "no value");
        stakes[msg.sender] += msg.value;
        totalStaked += msg.value;
    }

    function claim() external {
        uint256 amount = stakes[msg.sender];
        require(amount > 0, "nothing");
        uint256 reward = amount * rewardPerEth / 1 ether;
        stakes[msg.sender] = 0;
        totalStaked -= amount;
        payable(msg.sender).transfer(amount + reward);
    }
}
