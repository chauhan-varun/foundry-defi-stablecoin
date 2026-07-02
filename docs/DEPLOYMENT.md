# Valora Stablecoin Deployment Guide

## Prerequisites
- [Foundry](https://getfoundry.sh/) installed.
- RPC URL for target chain (Sepolia / Mainnet / Anvil).
- Private key or Hardware Wallet (Ledger/Trezor) configured.
- Etherscan API key for contract verification.

## Local Deployment (Anvil)

1. Start local node:
```bash
anvil
```

2. Deploy using Forge script:
```bash
forge script script/DeployDSC.s.sol:DeployDSC --rpc-url http://localhost:8545 --private-key <ANVIL_PRIVATE_KEY> --broadcast
```

## Testnet Deployment (Sepolia)

```bash
forge script script/DeployDSC.s.sol:DeployDSC \
  --rpc-url $SEPOLIA_RPC_URL \
  --account myAccount \
  --broadcast \
  --verify \
  --etherscan-api-key $ETHERSCAN_API_KEY \
  -vvvv
```

## Post-Deployment Verification
- Ensure `DSCEngine` is set as the `owner()` of `DecentralizedStableCoin`.
- Verify price feed addresses match target chain Chainlink feeds.
