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
        assertEq(es.name, "Pat");
    }
}
