// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract ArraysExercise {
    uint constant Y2K = 946702800;
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    uint[] public timestamps;
    address[] public senders;

    function getNumbers() public view returns (uint[] memory) {
        uint[] memory result = new uint[](numbers.length);
        for (uint i = 0; i < numbers.length; i++) {
            result[i] = numbers[i];
        }
        return result;
    }

    function resetNumbers() public {
        for (uint i = 0; i < 10; i++) {
            numbers[i] = i + 1;
        }
    }

    function appendToNumbers(uint[] calldata _toAppend) public {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    function afterY2K() public view returns (uint[] memory, address[] memory) {
        uint count = 0;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > Y2K) {
                count++;
            }
        }

        address[] memory sendersAfterY2K = new address[](count);
        uint[] memory timestampsAfterY2K = new uint[](count);

        uint idx = 0;

        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > Y2K) {
                sendersAfterY2K[idx] = senders[i];
                timestampsAfterY2K[idx] = timestamps[i];
                idx++;
            }
        }
        return (timestampsAfterY2K, sendersAfterY2K);
    }

    function resetSenders() public {
        delete senders;
    }

    function resetTimestamps() public {
        delete timestamps;
    }

    function getSendersLen() public view returns (uint) {
        return senders.length;
    }

    function getTimestampsLen() public view returns (uint) {
        return timestamps.length;
    }
}
