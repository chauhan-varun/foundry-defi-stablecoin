# Oracle Slippage & Staleness Protection Specification

## Objective
Prevent loss of collateral during rapid market price fluctuations or oracle updates.

## Technical Rules
1. **Freshness Checks**: Every Oracle read executes `OracleLib.staleCheckLatestRoundData()`.
2. **Revert Timeout**: Reads older than 3 hours cause the protocol transaction to revert.
3. **Liquidation Safety Margin**: Liquidators receive 10% bonus collateral to ensure incentive alignment even if collateral prices decline slightly during block inclusion.
