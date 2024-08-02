-include .env

.PHONY: all test build depoly

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy:
	@forge script script/DeployMoodNft.s.sol:DepolyMoodNft $(NETWORK_ARGS)


deploy-anvil: ; forge script ./script/DeployMoodNft.s.sol:DepolyMoodNft --rpc-url ${ANVIL_RPC_URL} --private-key ${DEFAULT_ANVIL_KEY} --broadcast -vvvvv

deploy-sepolia: ; forge script ./script/DeployMoodNft.s.sol:DepolyMoodNft --rpc-url ${SEPOLIA_RPC_URL} --private-key ${PRIVATE_KEY} --broadcast  --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvvv

mintNft-anvil: ; forge script ./script/interactions.s.sol:MintMoodNft --rpc-url  ${ANVIL_RPC_URL} --private-key ${DEFAULT_ANVIL_KEY} --broadcast -vvvvv


mintNft-sepolia: ; forge script ./script/interactions.s.sol:MintMoodNft --rpc-url  ${SEPOLIA_RPC_URL} --private-key ${PRIVATE_KEY} --broadcast -vvvvv


