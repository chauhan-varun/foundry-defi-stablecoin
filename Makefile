-include .env

.PHONY: all test clean deploy format snapshot anvil

all: clean remove install build

clean:
	@forge clean

remove:
	@rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules

install:
	@forge install cyfrin/foundry-devops@0.2.2 --no-commit
	@forge install smartcontractkit/chainlink-brownie-contracts@1.1.1 --no-commit
	@forge install openzeppelin/openzeppelin-contracts@v4.8.3 --no-commit

build:
	@forge build

test:
	@forge test

format:
	@forge fmt

snapshot:
	@forge snapshot

anvil:
	@anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1
