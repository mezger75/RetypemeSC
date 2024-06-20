// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import {Script, console2} from "forge-std/Script.sol";
import {SafeSingletonDeployer} from "../src/SafeSingletonDeployer.sol";
import {GamingContract} from "../src/GamingContract.sol";


contract GamingContractScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        SafeSingletonDeployer.broadcastDeploy({
            deployerPrivateKey: deployerPrivateKey,
            creationCode: type(GamingContract).creationCode,
            args: abi.encode(1),
            salt: bytes32("0x1234")
        });
    }
}