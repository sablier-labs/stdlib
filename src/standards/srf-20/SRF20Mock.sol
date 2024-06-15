// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.8.12;

import { SRF20 } from "../../standards/srf-20/SRF20.sol";

/// @notice Dummy mock contract for testing the SRF-20 implementation. The difference between this
/// and {SRF20} is that this mock can be deployed. Abstracts cannot be deployed.
/// @dev WARNING: This contract is for testing purposes only. Do not use in production.
contract SRF20Mock is SRF20 {
    constructor(string memory name, string memory symbol) SRF20(name, symbol) { }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function mint(address recipient, uint256 amount) external {
        _mint(recipient, amount);
    }
}
