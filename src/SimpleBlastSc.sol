// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

contract SimpleBlastSc {
    uint256 public myUint;
    string public myString;

    function newUint(uint256 _newValue) external {
        myUint = _newValue;
        myString = "not empty string!";
    }
}
