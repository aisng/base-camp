// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test, console, stdError} from "forge-std/Test.sol";
import {ArraysExercise} from "../src/ArraysExercise.sol";

contract TestArraysExercise is Test {
    ArraysExercise public ae;
    uint[] expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    uint[] expectedAppend = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 4, 3, 2, 1];
    uint[] toAppend = [4, 3, 2, 1];

    function setUp() public {
        ae = new ArraysExercise();
    }

    function test_numbers() public {
        assertEq(ae.getNumbers(), expected);
        ae.resetNumbers();
        assertEq(ae.getNumbers(), expected);
        ae.appendToNumbers(toAppend);
        assertEq(ae.getNumbers(), expectedAppend);
    }

    function test_saveTimestamp() public {
        address expectedSender = address(this);
        vm.prank(expectedSender);
        ae.saveTimestamp(10);
        assertEq(ae.timestamps(0), 10);
        assertEq(ae.senders(0), expectedSender);
    }

    function test_afterY2K() public {
        address expectedSender = address(this);
        vm.prank(expectedSender);
        ae.saveTimestamp(946702900);
        ae.saveTimestamp(946701999);
        (
            uint[] memory timestampsAfterY2K,
            address[] memory sendersAfterY2K
        ) = ae.afterY2K();
        assertEq(timestampsAfterY2K[0], 946702900);
        assertEq(sendersAfterY2K[0], expectedSender);
    }

    function test_resetSendersAndTimestamps() public {
        address expectedSender = address(this);
        vm.prank(expectedSender);
        ae.saveTimestamp(946702900);
        assertEq(ae.getSendersLen(), 1);
        assertEq(ae.getTimestampsLen(), 1);
        ae.resetSenders();
        assertEq(ae.getSendersLen(), 0);
        assertEq(ae.getTimestampsLen(), 1);
        ae.resetTimestamps();
        assertEq(ae.getTimestampsLen(), 0);
    }
}
