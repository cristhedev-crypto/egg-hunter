// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "contracts/egg-hunter/Hunter.sol";

contract RewardManager {
    using SafeERC20 for IERC20;

    address owner;

    IERC20 public _rewardToken;
    mapping(address => uint) public _previousChecked;
    uint256 public _dailyReward;

    uint256 public _exchageRate;

    Hunter public _rewardItem;

    constructor(uint256 dailyReward, uint256 exchangeRate) {
        owner = msg.sender;

        _dailyReward = dailyReward;
        _exchageRate = exchangeRate;

        _rewardItem = new Hunter(address(this));
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Must be owner to execute this function");
        _;
    }

    function setRewardToken(IERC20 rewardToken) external onlyOwner {
        _rewardToken = rewardToken;
    }

    function checkin() external {
        if (_previousChecked[msg.sender] != 0) {
            require(block.timestamp - _previousChecked[msg.sender] < 86400, "You have to wait 24 hours since the previous checkin!");
        }
        _rewardToken.safeTransfer(msg.sender, _dailyReward);
    }

    function exchangeReward() external {
        require(_rewardToken.balanceOf(msg.sender) > _exchageRate, "Insufficient Reward Token!");

        _rewardItem.mint(msg.sender);
    }

    function farm() external {
        _rewardToken.safeTransfer(msg.sender, _dailyReward / 4);
    }
}