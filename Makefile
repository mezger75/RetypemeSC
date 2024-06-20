# Define default shell
SHELL := /bin/bash

# RPC URLs and other constants
RPC_URL_POLYGON := polygon_amoy
RPC_URL_OPBNB := opbnb_testnet
RPC_URL_SCROLL := scroll_sepolia
RPC_URL_BASE := base_sepolia
RPC_URL_BLAST := blast_sepolia
RPC_URL_ETHEREUM := ethereum_sepolia
CONTRACT_SRC := src/GamingContract.sol:GamingContract
SCRIPT_PATH := script/GamingContract.s.sol:GamingContractScript

.PHONY: build test fmt deploy verify

build:
	forge build

test:
	forge test

fmt:
	forge fmt

# Deployment targets
deploy: deploy-polygon deploy-scroll deploy-blast deploy-ethereum

deploy-polygon:
	forge script $(SCRIPT_PATH) --rpc-url $(RPC_URL_POLYGON) --broadcast -vvv

# if gas price is not enough, increase it by one order
deploy-opbnb:
	forge script $(SCRIPT_PATH) --rpc-url $(RPC_URL_OPBNB) --evm-version paris --gas-price 28000 --broadcast -vvv

deploy-scroll:
	forge script $(SCRIPT_PATH) --rpc-url $(RPC_URL_SCROLL) --broadcast -vvv

deploy-base:
	forge script $(SCRIPT_PATH) --rpc-url $(RPC_URL_BASE) --broadcast -vvv

deploy-blast:
	forge script $(SCRIPT_PATH) --rpc-url $(RPC_URL_BLAST) --broadcast -vvv

deploy-ethereum:
	forge script $(SCRIPT_PATH) --rpc-url $(RPC_URL_ETHEREUM) --broadcast -vvv

# Verification targets
verify: verify-polygon verify-scroll verify-blast verify-ethereum

verify-polygon:
	forge verify-contract 0x $(CONTRACT_SRC) --rpc-url $(RPC_URL_POLYGON)

verify-scroll:
	forge verify-contract 0x $(CONTRACT_SRC) --rpc-url $(RPC_URL_SCROLL)

verify-blast:
	forge verify-contract 0x $(CONTRACT_SRC) --rpc-url $(RPC_URL_BLAST)

verify-ethereum:
	forge verify-contract 0x $(CONTRACT_SRC) --rpc-url $(RPC_URL_ETHEREUM)
