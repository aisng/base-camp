// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

error TooManyShares(uint16 _shares);

contract EmployeeStorage {
    uint16 private salary;
    uint16 private shares;
    uint256 public idNumber;
    string public name;

    constructor() {
        shares = 1000;
        name = "Pat";
        salary = 50000;
        idNumber = 112358132134;
    }

    function viewSalary() public view returns (uint16) {
        return salary;
    }

    function viewShares() public view returns (uint16) {
        return shares;
    }

    function grantShares(uint16 _newShares) public returns (uint16) {
        uint16 newAmount = shares + _newShares;

        if (_newShares > 5000) {
            revert("Too many shares");
        }

        if (newAmount > 5000) {
            revert TooManyShares(newAmount);
        }
        shares = newAmount;
        return newAmount;
    }

    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot)
        }
    }

    function debugResetShares() public {
        shares = 1000;
    }
}
