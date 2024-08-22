// SPDX-License-Identifier: MIT
pragma solidity >=0.8.12;

import { NativeTokens } from "../../precompiles/native-tokens/NativeTokens.sol";

/// @notice A mock contract playing the role of the "receiving" side in the single-
/// and multi-token transfer-and-call tests
contract ContractToTransferAndCallTo {
    using NativeTokens for address;

    function transferTokenForAFee(address recipient, uint256 tokenID, uint256 amount, uint256 fee) external payable {
        require(fee < amount, "Fee must be less than the amount to transfer");
        // TODO: check that the caller has transferred amount worth of the tokenID token

        // Transfer the token to the provided recipient.
        recipient.transfer(tokenID, amount - fee);
    }

    function transferMultipleTokensForAFee(
        address recipient,
        uint256[] calldata tokenIDs,
        uint256[] calldata amounts,
        uint256 fee
    )
        external
        payable
    {
        require(tokenIDs.length == amounts.length, "Token IDs and amounts must have the same length");

        for (uint256 i = 0; i < tokenIDs.length; i++) {
            require(fee < amounts[i], "Fee must be less than the amount to transfer");
            // TODO: check that the caller has transferred amounts[i] worth of the tokenIDs[i] token

            // Transfer the token to the provided recipient.
            recipient.transfer(tokenIDs[i], amounts[i] - fee);
        }
    }
}
