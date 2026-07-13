# Liquidator Bot Architecture & Strategy Guide

## Overview
Liquidators maintain protocol solvency by purchasing underwater collateral from positions where $\text{Health Factor} < 1.0$.

## Incentive Structure
- **Liquidation Bonus**: $10\%$ discount on collateral purchased.
- **Profit Calculation**:
  $$\text{Net Profit} = (\text{Collateral Amount} \times \text{Asset Price}) - \text{DSC Debt Paid} - \text{Gas Fees}$$

## Bot Execution Flow

```
1. Listen to DSCEngine events (DepositCollateral, MintDsc, CollateralRedeemed)
2. Maintain local state of user positions and health factors
3. Query Chainlink feeds off-chain to estimate positions near Health Factor < 1.0
4. Submit flashloan / liquidation transaction upon threshold breach
```

## Anti-MEV Guidelines
- Use Private RPC endpoints (e.g. Flashbots Protect) to submit liquidation bundles to prevent front-running / sandwich attacks by other searchers.
