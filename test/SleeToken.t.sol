// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {Test, console2, stdError} from "forge-std/Test.sol";
import {SleeToken} from "../src/SleeToken.sol";

contract SleeTokenTest is Test {
    SleeToken public token;
    address supplyOwnerAddress = makeAddr("BasedUser");
    address randomWalletAddress = makeAddr("WalletRitch");
    address anotherWalletAddress = makeAddr("WalletPoorRandom");
    error ERC20InvalidReceiver(address receiver);

    function setUp() public {
        vm.prank(supplyOwnerAddress);
        token = new SleeToken();
    }

    function test_name() public {
        assertEq(token.name(), "SleeToken");
    }

    function test_symbol() public {
        assertEq(token.symbol(), "SLEE");
    }

    function test_totalSupply() public {
        assertEq(token.totalSupply(), 999999999999000000000000);
    }

    function test_balanceOfAddress0() public {
        assertEq(token.balanceOf(address(0)), 0);
    }

    function test_balanceOfAddressSupplyOwner() public {
        assertEq(token.balanceOf(supplyOwnerAddress), 999999999999000000000000);
    }

    function test_transferRevertInvalidSender() public {
        vm.prank(address(0));
        vm.expectRevert(
            abi.encodeWithSignature("ERC20InvalidSender(address)", address(0))
        );
        token.transfer(randomWalletAddress, 3824);
    }

    function test_transferRevertInvalidReceiver() public {
        vm.prank(supplyOwnerAddress);
        vm.expectRevert(
            abi.encodeWithSignature("ERC20InvalidReceiver(address)", address(0))
        );
        token.transfer(address(0), 100);
    }

    function test_transferRevertInsufficientBallance() public {
        vm.prank(randomWalletAddress);
        // NOTE: Make sure to keep this string for `encodeWithSignature` free of spaces for the string (" ")
        vm.expectRevert(
            abi.encodeWithSignature(
                "ERC20InsufficientBalance(address,uint256,uint256)",
                randomWalletAddress,
                0,
                100
            )
        );
        token.transfer(supplyOwnerAddress, 100);
    }

    function test_transfer() public {
        vm.prank(supplyOwnerAddress);
        assertEq(token.transfer(randomWalletAddress, 10), true);
        assertEq(token.balanceOf(randomWalletAddress), 10);
        assertEq(token.balanceOf(supplyOwnerAddress), token.totalSupply() - 10);
    }

    function test_allowance() public {
        assertEq(token.allowance(supplyOwnerAddress, randomWalletAddress), 0);
    }
}
