
build:
	forge build

test:
	forge test

deploy-polygon:
	forge script script/GamingContract.s.sol:GamingContractScript --rpc-url amoy_polygon --broadcast -vvv

verify-polygon:
	forge verify-contract 0xb3Aa754f1664719489fb10e0c5F9B98D8AC232b9 src/GamingContract.sol:GamingContract --rpc-url amoy_polygon


deploy-scroll:
	forge script script/GamingContract.s.sol:GamingContractScript --rpc-url scroll_sepolia --broadcast -vvv

verify-scroll:
	forge verify-contract 0xf813B4E5D34079EBCc59adf39A7782AD989891Fe src/GamingContract.sol:GamingContract --rpc-url scroll_sepolia
