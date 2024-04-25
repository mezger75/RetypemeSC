// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "forge-std/Script.sol";
import "../src/GamingContract.sol";

contract GamingContractScript is Script {
    function run() external {
        uint256 deployedPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployedPrivateKey);
        new GamingContract();
        vm.stopBroadcast();
    }
}
