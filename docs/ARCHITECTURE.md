# Valora Stablecoin System Architecture

## Overview
Valora is an algorithmic, exogenous collateral-backed stablecoin protocol operating on Ethereum-compatible networks.

```
+------------------+         +-----------------------+         +---------------------+
|                  |         |                       |         |                     |
| Decentralized    | <------ |       DSCEngine       | ------> |     OracleLib       |
| StableCoin (DSC) |         | (Collateral/Minting)  |         | (Stale Price Guard) |
|                  |         |                       |         |                     |
+------------------+         +-----------------------+         +---------------------+
                                         |                                |
                                         v                                v
                               +-------------------+            +-------------------+
                               | Chainlink Oracles |            | WETH / WBTC Tokens|
                               +-------------------+            +-------------------+
```

## Key Components

1. **DecentralizedStableCoin (DSC)**
   - ERC-20 compliant token contract.
   - Controlled solely by the `DSCEngine` contract.
   - `mint` and `burn` restricted to owner (`DSCEngine`).

2. **DSCEngine**
   - Core state machine enforcing over-collateralization (min 200% collateral ratio).
   - Manages collateral deposits, token minting, token burning, and liquidations.
   - Implements health factor checks (`Health Factor < 1.0` triggers liquidation).

3. **OracleLib**
   - Wrapper around Chainlink AggregatorV3 price feeds.
   - Enforces freshness timeouts to protect against stale oracle updates.

## Protocol Invariants
- Total USD value of collateral must always exceed total DSC supply.
- No user can mint DSC if their health factor drops below 1.0.
