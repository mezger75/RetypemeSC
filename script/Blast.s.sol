// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/SimpleBlastSc.sol";

contract BlastDeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        new SimpleBlastSc();

        vm.stopBroadcast();
    }
}

// forge script script/Blast.s.sol:BlastDeployScript --rpc-url blast_sepolia --broadcast -vvvv
// forge verify-contract 0x42b3FC904150C591463DbB0c72e4ab7Da6509B3B src/SimpleBlastSc.sol:SimpleBlastSc --chain blast-sepolia
