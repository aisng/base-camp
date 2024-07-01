// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SleeToken is ERC20 {
    uint256 public constant INITIAL_SUPPLY = 1_000_000 * 1 ether;
    uint256 public constant BURN_PERCENTAGE = 1;

    constructor() ERC20("SleeToken", "SLEE") {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function _update(
        address sender,
        address recipient,
        uint256 amount
    ) internal override {
        uint256 burnAmount = (amount * BURN_PERCENTAGE) / 1_000_000_000_000;
        super._update(sender, recipient, amount - burnAmount);
        super._update(sender, address(0), burnAmount);
    }
}
