// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

error AfterHours(uint _time);
contract ControlStructures {
    function fizzBuzz(uint _number) public pure returns (string memory) {
        if (_number % 3 == 0 && _number % 5 == 0) {
            return "FizzBuzz";
        } else if (_number % 3 == 0) {
            return "Fizz";
        } else if (_number % 5 == 0) {
            return "Buzz";
        } else {
            return "Splat";
        }
    }

    function doNotDisturb(uint _time) public pure returns (string memory) {
        string memory message;
        assert(_time <= 2400);
        if (_time > 2200 || _time < 800) {
            revert AfterHours(_time);
        } else if (1200 < _time && _time < 1259) {
            revert("At lunch!");
        } else if (800 < _time && _time < 1199) {
            message = "Morning!";
        } else if (1300 < _time && _time < 1799) {
            message = "Afternoon!";
        } else if (1800 < _time && _time < 2200) {
            message = "Evening!";
        }
        return message;
    }
}
