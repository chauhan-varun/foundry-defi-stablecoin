# Gas Optimization Report & Best Practices

## Applied Optimizations

1. **Custom Errors vs Require Strings**
   - Replaced string revert reasons with custom errors (e.g. `DSCEngine__NeedsMoreThanZero()`).
   - Saves ~200 gas per revert branch.

2. **Immutable and Constant Storage Variables**
   - Storage slots saved for price feed parameters and token decimals.

3. **Cached Storage Reads in Loops**
   - In `getAccountCollateralValue()`, collateral token array lengths and storage mappings are cached locally.

## Recommendations for Future Optimization

- **Calldata vs Memory for Function Inputs**:
  Use `calldata` for array parameters in external view functions to prevent unnecessary memory allocations.
- **Unchecked Arithmetic**:
  Apply `unchecked` blocks for loop counters where overflow is mathematically impossible.
