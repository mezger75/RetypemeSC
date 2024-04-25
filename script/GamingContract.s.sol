// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/GamingContract.sol";

// forge script script/GamingContract.s.sol:GamingContractScript --rpc-url amoy_polygon --broadcast -vvvv
// forge verify-contract 0xb3Aa754f1664719489fb10e0c5F9B98D8AC232b9 src/GamingContract.sol:GamingContract --rpc-url amoy_polygon
contract GamingContractScript is Script {
    function run() external {
        uint256 deployedPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployedPrivateKey);
        new GamingContract();
        vm.stopBroadcast();
    }
}
