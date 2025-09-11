// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Staking {
    // Mapping of staker addresses to their staked ETH amount
    mapping(address => uint256) public stakes;

    // Total ETH staked in the contract
    uint256 public totalStaked;

    // Reward rate: 0.01 ETH per 1 ETH staked (for demo purposes)
    uint256 public constant REWARD_PER_ETH = 1e16;

    /// @notice Stake ETH into the contract
    function stake() external payable {
        uint256 amount = msg.value;
        require(amount > 0, "Stake amount must be greater than zero");

        stakes[msg.sender] += amount;
        totalStaked += amount;
    }

    /// @notice Claim your staked ETH plus rewards
    function claim() external {
        uint256 amount = stakes[msg.sender];
        require(amount > 0, "No staked amount to claim");

        // Calculate reward
        uint256 reward = (amount * REWARD_PER_ETH) / 1 ether;

        // Effects before interactions
        stakes[msg.sender] = 0;
        totalStaked -= amount;

        // Interactions
        payable(msg.sender).transfer(amount + reward);
    }
}
