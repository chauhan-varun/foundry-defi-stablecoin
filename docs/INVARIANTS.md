# Protocol Safety Invariants

This document details the formal invariants maintained across the Valora Stablecoin System.

## Primary Invariants

1. **Collateral Over-valuation Invariant**
   - $\sum \text{USD Value of Deposited Collateral} \ge \text{Total Supply of DSC}$
   - The total collateral backing the system must never drop below 100% of the total minted DSC debt in USD terms.

2. **Health Factor Bound**
   - For any active user account $u$:
     $$\text{Health Factor}_u = \frac{\sum (\text{Collateral}_i \times \text{Threshold})}{\text{Total Debt}_u} \ge 1.0$$
   - If $\text{Health Factor}_u < 1.0$, the account is eligible for immediate liquidation by any third-party liquidator.

3. **Oracle Freshness Requirement**
   - All Chainlink price feeds must return heartbeat updates within $3 \text{ hours}$.
   - If an oracle feed exceeds the staleness threshold, transactions interacting with that asset revert to prevent bad debt.

4. **Access Control Enforcement**
   - Only `DSCEngine` possesses the authority to call `mint()` or `burn()` on the `DecentralizedStableCoin` token contract.
