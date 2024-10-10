// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Hunter is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address private _rewardManager;

    constructor(address rewardManager) ERC721("Hunter", "HUNTER") {
        _rewardManager = rewardManager;
    }

    function mint(address receiver) public returns (uint256) {
        require(msg.sender == _rewardManager, "Forbidden!");

        uint256 newItemId = _tokenIds.current();
        _mint(receiver, newItemId);
        _setTokenURI(newItemId, "https://cdn.pixabay.com/photo/2016/06/08/11/15/hunter-1443648_960_720.png");

        _tokenIds.increment();
        return newItemId;
    }
}