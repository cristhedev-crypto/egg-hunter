// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Egg is ERC20 {
    constructor(uint256 initialSupply, address rewardManager) ERC20("Egg", "EGG") {
        _mint(rewardManager, initialSupply);
    }
}