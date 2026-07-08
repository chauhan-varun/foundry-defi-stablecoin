# Emergency Circuit Breaker Specification

## Objective
Provide an architectural proposal for an emergency pause mechanism to protect protocol collateral during extreme market volatility or oracle anomaly events.

## Features & Scenarios

1. **Volatility Trigger**
   - If an asset's price drops by $> 30\%$ in a single block, the system automatically flags oracle updates for manual verification.

2. **Pause Scope**
   - `mintDsc` and `depositCollateral` can be selectively paused by emergency multisig without freezing liquidations (`liquidate`).
   - Liquidations must remain active to prevent systemic under-collateralization.

3. **Unpause Delay**
   - Unpausing requires a 24-hour timelock to prevent governance front-running.
