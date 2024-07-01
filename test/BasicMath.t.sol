// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test, console2, stdError} from "forge-std/Test.sol";
import {BasicMath} from "../src/BasicMath.sol";

contract TestBasicMath is Test {
    BasicMath public bm;

    function setUp() public {
        bm = new BasicMath();
    }

    function test_adderNoOverflow() public view {
        (uint res, bool err) = bm.adder(1, 3);
        assertEq(res, 4);
        assertEq(err, false);
    }

    function test_adderWithOverflow() public view {
        (uint res, bool err) = bm.adder(2 ** (256 - 1), 2 ** (256 - 1));
        assertEq(res, 0);
        assertEq(err, true);
    }

    function test_subtractorNoUnderflow() public view {
        (uint res, bool err) = bm.subtractor(5, 3);
        assertEq(res, 2);
        assertEq(err, false);
    }

    function test_subtractorWithUnderflow() public view {
        (uint res, bool err) = bm.subtractor(1, 3);
        assertEq(res, 0);
        assertEq(err, true);
    }
}
