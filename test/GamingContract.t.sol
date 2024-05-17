// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GamingContract} from "../src/GamingContract.sol";

contract GamingContractTest is Test {

    GamingContract public gamingContract;
    address public self = address(this);
    address public alice = address(0x123);
    address public bob = address(0x456);

    function setUp() public {
        gamingContract = new GamingContract();
        vm.deal(alice, 1 ether);
        vm.deal(bob, 1 ether);
    }

    function testOwnerIsInitialSetup() public view {
        console.log(gamingContract.owner());
        assertEq(gamingContract.owner(), address(this));
    }

    // owner should be the deployer
    function testOwnerIsDeployer() public view {
        assertEq(gamingContract.owner(), address(this));
    }

    // check deposit to inGameBalance
    function testDeposit() public {
        vm.prank(alice);
        gamingContract.deposit{value: 0.1 ether}();
        assertEq(gamingContract.getBalance(alice), 0.1 ether);
    }

    function testDepositInsufficientBalance() public {
        vm.prank(alice);
        vm.expectRevert("Insufficient balance");
        gamingContract.withdraw(1 ether);
    }

    // this test is to check joinGame function and endGame
    function testGame() public {
        // Alice deposits
        vm.prank(alice);
        gamingContract.deposit{value: 0.001 ether}();

        // Bob deposits
        vm.prank(bob);
        gamingContract.deposit{value: 0.001 ether}();

        // Alice joins the game
        vm.prank(alice);
        gamingContract.joinGame(1);

        // Bob joins the game
        vm.prank(bob);
        gamingContract.joinGame(1);

        // Check if the game started
//        (uint256 depositAmount, uint256 sessionId, GamingContract.GameStatus status, address[] memory players, address winner) = gamingContract.gameSessions(1);
//        assertEq(uint(status), uint(GamingContract.GameStatus.STARTED));

        // End the game with Alice as the winner
        uint prevBalance = gamingContract.getBalance(alice);
        gamingContract.endGame(1, alice);
        uint winnings = 0.002 ether - ((0.002 ether * gamingContract.commissionRate()) / 100);
        assertEq(gamingContract.getBalance(alice), prevBalance + winnings);

        // Check if the game ended
//        (, , status, , ) = gamingContract.gameSessions(1);
//        assertEq(uint(status), uint(GamingContract.GameStatus.ENDED));
    }

    // test withdraw from inGameBalance
    function testWithdraw() public {
        vm.prank(alice);
        gamingContract.deposit{value: 0.1 ether}();
        uint prevBalance = alice.balance;
        vm.prank(alice);
        gamingContract.withdraw(0.1 ether);
        assertEq(alice.balance, prevBalance + 0.1 ether);
        assertEq(gamingContract.getBalance(alice), 0);
    }

    // test change commission rate by owner
    function testChangeCommissionRate() public {
        uint newRate = 10;
        gamingContract.changeCommissionRate(newRate);
        assertEq(gamingContract.commissionRate(), newRate);
    }

    function testChangeCommissionRateNotOwner() public {
        uint newRate = 10;
        vm.prank(alice);
        vm.expectRevert("Not the owner");
        gamingContract.changeCommissionRate(newRate);
    }

    // test change fixed deposit amount by owner
    function testChangeFixedDepositAmount() public {
        uint newAmount = 0.002 ether;
        gamingContract.changeFixedDepositAmount(newAmount);
        assertEq(gamingContract.fixedDepositAmount(), newAmount);
    }

    function testChangeFixedDepositAmountNotOwner() public {
        uint newAmount = 0.002 ether;
        vm.prank(alice);
        vm.expectRevert("Not the owner");
        gamingContract.changeFixedDepositAmount(newAmount);
    }

    // test withdraw funds from contract by owner
//    function testWithdrawFundsFromContract() public {
//        vm.prank(alice);
//        gamingContract.deposit{value: 0.1 ether}();
//        uint prevBalance = address(this).balance;
//        gamingContract.withdrawFundsFromContract();
//        assertEq(address(this).balance, prevBalance + 0.1 ether);
//    }

    function testWithdrawFundsFromContractNotOwner() public {
        vm.prank(alice);
        vm.expectRevert("Not the owner");
        gamingContract.withdrawFundsFromContract();
    }

    // test withdraw commission from contract by owner
//    function testWithdrawCommissionFromContract() public {
//        vm.prank(alice);
//        gamingContract.deposit{value: 0.001 ether}();
//        vm.prank(bob);
//        gamingContract.deposit{value: 0.001 ether}();
//        vm.prank(alice);
//        gamingContract.joinGame(1);
//        vm.prank(bob);
//        gamingContract.joinGame(1);
//        gamingContract.endGame(1, alice);
//        uint commission = 0.0002 ether; // 20% of 0.002 ether
//        uint prevBalance = address(this).balance;
//        gamingContract.withdrawCommissionFromContract();
//        assertEq(address(this).balance, prevBalance + commission);
//    }

    function testWithdrawCommissionFromContractNotOwner() public {
        vm.prank(alice);
        vm.expectRevert("Not the owner");
        gamingContract.withdrawCommissionFromContract();
    }
}
