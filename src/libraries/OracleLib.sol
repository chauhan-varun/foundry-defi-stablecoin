// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/*
 * @title OracleLib
 * @author Varun Chauhan
 * @notice This library is used to check the Chainlink Oracle for stale data.
 * If a price is stale, functions will revert, and render the DSCEngine unusable - this is by design.
 * We want the DSCEngine to freeze if prices become stale.
 *
 * So if the Chainlink network explodes and you have a lot of money locked in the protocol... too bad.
 */
library OracleLib {
    error OracleLib__StalePrice();

    uint256 private constant TIMEOUT = 3 hours;

    /**
     * @notice Fetches latest round data from Chainlink feed and validates freshness
     * @param chainlinkFeed The Chainlink AggregatorV3Interface instance to query
     * @return roundId The round identifier
     * @return answer The price answer from the feed
     * @return startedAt Timestamp when the round started
     * @return updatedAt Timestamp when the round was updated
     * @return answeredInRound Round ID in which the answer was computed
     * @custom:throws OracleLib__StalePrice if data has not been updated within TIMEOUT
     */
    function staleCheckLatestRoundData(
        AggregatorV3Interface chainlinkFeed
    ) public view returns (uint80, int256, uint256, uint256, uint80) {
        (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        ) = chainlinkFeed.latestRoundData();

        if (updatedAt == 0 || answeredInRound < roundId) {
            revert OracleLib__StalePrice();
        }
        uint256 secondsSince = block.timestamp - updatedAt;
        if (secondsSince > TIMEOUT) revert OracleLib__StalePrice();

        return (roundId, answer, startedAt, updatedAt, answeredInRound);
    }

    function getTimeout(
        AggregatorV3Interface /* chainlinkFeed */
    ) public pure returns (uint256) {
        return TIMEOUT;
    }
}
