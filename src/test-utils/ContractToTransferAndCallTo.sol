// SPDX-License-Identifier: MIT
pragma solidity >=0.8.12;

import { NativeTokens } from "../precompiles/native-tokens/NativeTokens.sol";

/// @notice A mock contract playing the role of the "receiving" side in the single-
/// and multi-token transfer-and-call tests
contract ContractToTransferAndCallTo {
    using NativeTokens for address;

    function transferTokenForAFee(address recipient, uint256 tokenID, uint256 amount, uint256 fee) external payable {
        require(fee < amount, "Fee must be less than the amount to transfer");

        // Make sure the caller has transferred enough tokenID tokens
        (uint256[] memory tokenIds, uint256[] memory tokenAmounts) = address(this).getCallValues();
        require(tokenIds.length == 1 && tokenAmounts.length == 1, "Caller must have transferred exactly one token");
        require(tokenIds[0] == tokenID && tokenAmounts[0] == amount, "Caller must transfer the token to the callee");

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

            // Make sure the caller has transferred amounts[i] worth of the tokenIDs[i] token
            require(
                enoughTokensTransferred(tokenIDs[i], amounts[i], tokenIDs, amounts), "Not enough tokens transferred"
            );

            // Transfer the token to the provided recipient.
            recipient.transfer(tokenIDs[i], amounts[i] - fee);
        }
    }

    function enoughTokensTransferred(
        uint256 tokenId,
        uint256 tokenAmount,
        uint256[] memory tokenIds,
        uint256[] memory tokenAmounts
    )
        internal
        pure
        returns (bool)
    {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            if (tokenIds[i] == tokenId && tokenAmounts[i] == tokenAmount) {
                return true;
            }
        }
        return false;
    }
}
