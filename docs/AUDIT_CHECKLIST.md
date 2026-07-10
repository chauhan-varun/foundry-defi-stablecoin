# Security Audit & Code Review Checklist

## 1. Access Control
- [x] Only `DSCEngine` can mint DSC tokens.
- [x] Only `DSCEngine` can burn DSC tokens directly.
- [x] `OracleLib` functions are `public` and `view` only.

## 2. Arithmetic & Edge Cases
- [x] Division by zero prevented in Health Factor calculations.
- [x] All zero-value transactions (mint/deposit/redeem/burn) revert with custom error `DSCEngine__AmountMustBeGreaterThanZero()`.
- [x] Chainlink oracle freshness checks (`staleCheckLatestRoundData`) active.

## 3. Reentrancy & State Changes
- [x] All state changes performed prior to external token transfers (Checks-Effects-Interactions pattern).
- [x] `nonReentrant` modifier applied to external state-modifying functions in `DSCEngine`.
