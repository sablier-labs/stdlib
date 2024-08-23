// SPDX-License-Identifier: MIT
pragma solidity >=0.8.12;

import { PRECOMPILE_NATIVE_TOKENS } from "../../Constants.sol";
import { StdLib_UnknownError } from "../../Errors.sol";
import { INativeTokens } from "./INativeTokens.sol";

library NativeTokens {
    /*//////////////////////////////////////////////////////////////////////////
                                 CONSTANT FUNCTIONS
    //////////////////////////////////////////////////////////////////////////*/

    /// @notice Returns the balance of the `account` for the native token `tokenID`.
    /// @param tokenID The ID of the native token to query the balance of.
    /// @param account The address to query the balance of.
    /// @return The balance of the `account` for the native token `tokenID`, denoted in 18 decimals.
    function balanceOf(address account, uint256 tokenID) internal view returns (uint256) {
        // ABI encode the input parameters.
        bytes memory callData = abi.encodeCall(INativeTokens.balanceOf, (account, tokenID));

        // Call the precompile.
        (bool success, bytes memory returnData) = PRECOMPILE_NATIVE_TOKENS.staticcall(callData);

        // This is an unexpected error since the VM should have panicked if the call failed.
        if (!success) {
            revert StdLib_UnknownError("NativeTokens: balanceOf failed");
        }

        // Decode the return data.
        return abi.decode(returnData, (uint256));
    }

    /// @notice Returns the token ids and amounts of the Native Tokens transferred in the context
    /// of the current contract call.
    ///
    /// Requirements:
    /// - The caller of this function must be a contract.
    ///
    /// @return tokenIDs The IDs of the transferred Native Tokens.
    /// @return amounts The amounts of the transferred Native Tokens.
    function getCallValues(address notUsed) internal returns (uint256[] memory, uint256[] memory) {
        notUsed;
        // ABI encode the input parameters.
        bytes memory callData = abi.encodeCall(INativeTokens.getCallValues, ());

        // Call the precompile.
        (bool success, bytes memory returnData) = PRECOMPILE_NATIVE_TOKENS.delegatecall(callData);

        // This is an unexpected error since the VM should have panicked if the call failed.
        if (!success) {
            revert StdLib_UnknownError("NativeTokens: getCallValues failed");
        }

        // Decode the return data.
        return abi.decode(returnData, (uint256[], uint256[]));
    }

    /*//////////////////////////////////////////////////////////////////////////
                         USER-FACING NON-CONSTANT FUNCTIONS
    //////////////////////////////////////////////////////////////////////////*/

    /// @notice Burns `amount` tokens with the sub-identifier `sub_id` from the `holder`'s account.
    /// @dev Generates a Burn receipt.
    ///
    /// Requirements:
    /// - The caller of this function must be a contract.
    /// - The holder must have at least `amount` tokens.
    ///
    /// @param holder The address to burn native tokens from.
    /// @param subID The sub-identifier of the native token to burn.
    /// @param amount The quantity of native tokens to burn.
    function burn(address holder, uint256 subID, uint256 amount) internal {
        // ABI encode the input parameters.
        bytes memory callData = abi.encodeCall(INativeTokens.burn, (subID, holder, amount));

        // Call the precompile, ignoring the response since the VM will panic if there's an issue.
        (bool response,) = PRECOMPILE_NATIVE_TOKENS.delegatecall(callData);
        response;
    }

    /// @notice Mints `amount` tokens with sub-identifier `subID` to the provided `recipient`.
    /// @dev Generates a Mint receipt.
    ///
    /// Requirements:
    /// - The caller of this function must be a contract.
    /// - The `recipient`'s balance must not overflow.
    ///
    /// @param recipient The address to mint native tokens to.
    /// @param subID The sub-identifier of the native token to mint.
    /// @param amount The quantity of native tokens to mint.
    function mint(address recipient, uint256 subID, uint256 amount) internal {
        // ABI encode the input parameters.
        bytes memory callData = abi.encodeCall(INativeTokens.mint, (subID, recipient, amount));

        // Call the precompile, ignoring the response since the VM will panic if there's an issue.
        (bool response,) = PRECOMPILE_NATIVE_TOKENS.delegatecall(callData);
        response;
    }

    /// @notice Transfers `amount` of native tokens from the calling contract to the recipient `to`.
    /// @dev In SabVM, contracts cannot transfer native tokens on behalf of other addresses.
    ///
    /// Generates a Transfer receipt.
    ///
    /// Requirements:
    /// - The calling contract must have at least `amount` tokens.
    ///
    /// @param to The address of the recipient.
    /// @param tokenID The ID of the native token to transfer.
    /// @param amount The quantity of native tokens to transfer.
    function transfer(address to, uint256 tokenID, uint256 amount) internal {
        // ABI encode the input parameters.
        bytes memory callData = abi.encodeCall(INativeTokens.transfer, (to, tokenID, amount));

        // Call the precompile, ignoring the response because the VM will panic if there's an issue.
        (bool response,) = PRECOMPILE_NATIVE_TOKENS.delegatecall(callData);
        response;
    }

    /// @notice Transfers `amount` of native tokens from the calling contract to the recipient `to`, and calls the
    /// `callee` with the calldata `data`.
    /// @dev Generates a Transfer receipt.
    ///
    /// Requirements:
    /// - The calling contract must have at least `amount` tokens.
    ///
    /// @param recipientAndCallee The address of the contract recipient of the tokens which will, also, be called.
    /// @param tokenID The sub-identifier of the native token to transfer.
    /// @param amount The quantity of native tokens to transfer.
    /// @param data The call data to pass to the `callee`.
    function transferAndCall(
        address recipientAndCallee,
        uint256 tokenID,
        uint256 amount,
        bytes calldata data
    )
        internal
    {
        // ABI encode the input parameters.
        bytes memory callData =
            abi.encodeCall(INativeTokens.transferAndCall, (recipientAndCallee, tokenID, amount, data));

        // Call the precompile, ignoring the response because the VM will panic if there's an issue.
        (bool response,) = PRECOMPILE_NATIVE_TOKENS.delegatecall(callData);
        response;
    }

    /// @notice Performs multiple native token transfers from the calling contract to the recipient `to`.
    /// @dev In SabVM, contracts cannot transfer native tokens on behalf of other addresses.
    /// Generates multiple Transfer receipts.
    ///
    /// Requirements:
    /// - The calling contract must have at least `amounts[i]` tokens for each token ID `tokenIDs[i]`.
    ///
    /// @param to The address of the recipient.
    /// @param tokenIDs The IDs of the native tokens to transfer.
    /// @param amounts The quantities of native tokens to transfer.
    function transferMultiple(address to, uint256[] calldata tokenIDs, uint256[] calldata amounts) internal {
        // ABI encode the input parameters.
        bytes memory callData = abi.encodeCall(INativeTokens.transferMultiple, (to, tokenIDs, amounts));

        // Call the precompile, ignoring the response because the VM will panic if there's an issue.
        (bool response,) = PRECOMPILE_NATIVE_TOKENS.delegatecall(callData);
        response;
    }

    /// @notice Performs multiple native token transfers from the calling contract to the recipient `to`, and calls
    /// the
    /// `callee` with the calldata `data`.
    /// @dev Generates multiple Transfer receipts.
    ///
    /// Requirements:
    /// - The calling contract must have at least `amounts[i]` tokens for each token ID `tokenIDs[i]`.
    ///
    /// @param recipientAndCallee The address of the contract recipient of the tokens which will, also, be called.
    /// @param tokenIDs The IDs of the native tokens to transfer.
    /// @param amounts The quantities of native tokens to transfer.
    /// @param data The call data to pass to the `callee`.
    function transferMultipleAndCall(
        address recipientAndCallee,
        uint256[] calldata tokenIDs,
        uint256[] calldata amounts,
        bytes calldata data
    )
        internal
    {
        // ABI encode the input parameters.
        bytes memory callData =
            abi.encodeCall(INativeTokens.transferMultipleAndCall, (recipientAndCallee, tokenIDs, amounts, data));

        // Call the precompile, ignoring the response because the VM will panic if there's an issue.
        (bool response,) = PRECOMPILE_NATIVE_TOKENS.delegatecall(callData);
        response;
    }
}
