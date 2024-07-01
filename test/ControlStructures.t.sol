// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {Test, console2, stdError} from "forge-std/Test.sol";
import {ControlStructures, AfterHours} from "../src/ControlStructures.sol";

contract TestControlStructures is Test {
    ControlStructures public cs;

    function setUp() public {
        cs = new ControlStructures();
    }

    function test_fizzBuzz() public view {
        assertEq(cs.fizzBuzz(4), "Splat");
        assertEq(cs.fizzBuzz(3), "Fizz");
        assertEq(cs.fizzBuzz(5), "Buzz");
        assertEq(cs.fizzBuzz(15), "FizzBuzz");
    }

    function test_doNotDisturb() public {
        vm.expectRevert(stdError.assertionError);
        cs.doNotDisturb(2422);
        vm.expectRevert(abi.encodeWithSelector(AfterHours.selector, 2202));
        cs.doNotDisturb(2202);
        vm.expectRevert("At lunch!");
        cs.doNotDisturb(1234);
        vm.expectRevert(abi.encodeWithSelector(AfterHours.selector, 600));
        cs.doNotDisturb(600);
        assertEq(cs.doNotDisturb(803), "Morning!");
        assertEq(cs.doNotDisturb(2144), "Evening!");
    }
}
