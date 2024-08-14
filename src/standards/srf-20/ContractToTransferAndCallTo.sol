// SPDX-License-Identifier: MIT
pragma solidity >=0.8.12;

import { NativeTokens } from "../../precompiles/native-tokens/NativeTokens.sol";

/// @notice A mock contract playing the role of the "receiving" side in the single-
/// and multi-token transfer-and-call tests
contract ContractToTransferAndCallTo {
    using NativeTokens for address;

    function transferTokenForAFee(address recipient, uint256 tokenID, uint256 amount, uint256 fee) external payable {
        // TODO: check that the caller has transferred an amount == transfer + fee

        require(fee < amount, "Fee must be less than the amount to transfer");
        //require(NativeTokens.balanceOf(tokenID, address(this)) == amount+fee, "Not enough balance to transfer");

        // Transfer the token to the provided recipient.
        recipient.transfer(tokenID, amount - fee);
    }
}
