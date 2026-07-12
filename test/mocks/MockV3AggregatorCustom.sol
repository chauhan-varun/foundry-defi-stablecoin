// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {MockV3Aggregator} from "./MockV3Aggregator.sol";

/**
 * @title MockV3AggregatorCustom
 * @notice Extended Chainlink MockAggregator for custom price feed manipulation during testing
 */
contract MockV3AggregatorCustom is MockV3Aggregator {
    constructor(uint8 _decimals, int256 _initialAnswer)
        MockV3Aggregator(_decimals, _initialAnswer)
    {}

    function setStalePrice(int256 _answer, uint256 _updatedAt) external {
        updateRoundData(uint80(latestRound + 1), _answer, _updatedAt, _updatedAt);
    }
}
