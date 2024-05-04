// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() external {
        bytes32 salt = keccak256(abi.encodePacked(address(this), vm.envUint("PRIVATE_KEY")));

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Counter{salt: salt}();
        vm.stopBroadcast();
    }

}
