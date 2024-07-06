// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test, console, stdError} from "forge-std/Test.sol";
import {EmployeeStorage, TooManyShares} from "../src/EmployeeStorage.sol";

contract TestEmployeeStorage is Test {
    EmployeeStorage public es;

    function setUp() public {
        es = new EmployeeStorage();
    }

    function test_employeeStorage() public {
        assertEq(es.name(), "Pat");
        assertEq(es.idNumber(), 112358132134);
        assertEq(es.viewSalary(), 50000);
        assertEq(es.viewShares(), 1000);
        assertEq(es.grantShares(1000), 2000);
        assertEq(es.viewShares(), 2000);
        vm.expectRevert(abi.encodeWithSelector(TooManyShares.selector, 5010));
        es.grantShares(3010);
        assertEq(es.viewShares(), 2000);
        vm.expectRevert("Too many shares");
        es.grantShares(6000);
    }
}
