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
    function balanceOf(uint256 tokenID, address account) internal view returns (uint256) {
        // ABI encode the input parameters.
        bytes memory precompileData = abi.encodeCall(INativeTokens.balanceOf, (tokenID, account));

        // Call the precompile.
        (bool success, bytes memory returnData) = PRECOMPILE_NATIVE_TOKENS.staticcall(precompileData);

        // This is an unexpected error since the VM should have panicked if the call failed.
        if (!success) {
            revert StdLib_UnknownError("NativeTokens: balanceOf failed");
        }

        // Decode the return data.
        return abi.decode(returnData, (uint256));
    }

    /*//////////////////////////////////////////////////////////////////////////
                         USER-FACING NON-CONSTANT FUNCTIONS
    //////////////////////////////////////////////////////////////////////////*/

    /// @notice Burns `amount` tokens with the sub-identifier `sub_id` from the `holder`'s account.
    /// @dev Generates a Burn receipt.
    ///
    /// Requirements:
    /// - The holder must have at least `amount` tokens.
    ///
    /// @param holder The address to burn native tokens from.
    /// @param subID The sub-identifier of the native token to burn.
    /// @param amount The quantity of native tokens to burn.
    function burn(address holder, bytes32 subID, uint256 amount) internal {
        // ABI encode the input parameters.
        bytes memory precompileData = abi.encodeCall(INativeTokens.burn, (holder, subID, amount));

        // Call the precompile, ignoring the response since the VM will panic if there's an issue.
        (bool response,) = PRECOMPILE_NATIVE_TOKENS.delegatecall(precompileData);
        response;
    }

    /// @notice Mints `amount` tokens with sub-identifier `subID` to the provided `recipient`.
    /// @dev Generates a Mint receipt.
    ///
    /// Requirements:
    /// - The `recipient`'s balance must not overflow.
    ///
    /// @param recipient The address to mint native tokens to.
    /// @param subID The sub-identifier of the native token to mint.
    /// @param amount The quantity of native tokens to mint.
    function mint(address recipient, bytes32 subID, uint256 amount) internal {
        // ABI encode the input parameters.
        bytes memory precompileData = abi.encodeCall(INativeTokens.mint, (recipient, subID, amount));

        // Call the precompile, ignoring the response since the VM will panic if there's an issue.
        (bool response,) = PRECOMPILE_NATIVE_TOKENS.delegatecall(precompileData);
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
    function transfer(address to, bytes32 tokenID, uint256 amount) internal {
        // The address in the calling contract.
        address from = address(this);

        // ABI encode the input parameters.
        bytes memory precompileData = abi.encodeCall(INativeTokens.transfer, (from, to, tokenID, amount));

        // Call the precompile, ignoring the response because the VM will panic if there's an issue.
        (bool response,) = PRECOMPILE_NATIVE_TOKENS.delegatecall(precompileData);
        response;
    }

    /// @notice Transfers `amount` of native tokens from the calling contract to the recipient `to`, and calls the
    /// `callee` with the calldata `data`.
    /// @dev Generates a Transfer receipt.
    ///
    /// Requirements:
    /// - The calling contract must have at least `amount` tokens.
    ///
    /// @param to The address of the recipient.
    /// @param tokenID The sub-identifier of the native token to transfer.
    /// @param amount The quantity of native tokens to transfer.
    /// @param callee The address of the contract to call after the transfer.
    /// @param data The call data to pass to the `callee`.
    function transferAndCall(
        address to,
        bytes32 tokenID,
        uint256 amount,
        address callee,
        bytes calldata data
    )
        internal
    {
        // The address in the calling contract.
        address from = address(this);

        // ABI encode the input parameters.
        bytes memory precompileData =
            abi.encodeCall(INativeTokens.transferAndCall, (from, to, tokenID, amount, callee, data));

        // Call the precompile, ignoring the response because the VM will panic if there's an issue.
        (bool response,) = PRECOMPILE_NATIVE_TOKENS.delegatecall(precompileData);
        response;
    }

    /// @notice Performs multiple native token transfers from the calling contract to the recipients `to`.
    /// @dev In SabVM, contracts cannot transfer native tokens on behalf of other addresses.
    /// Generates multiple Transfer receipts.
    ///
    /// Requirements:
    /// - The calling contract must have at least `amounts[i]` tokens for each token ID `tokenIDs[i]`.
    ///
    /// @param to The addresses of the recipients.
    /// @param tokenIDs The IDs of the native tokens to transfer.
    /// @param amounts The quantities of native tokens to transfer.
    function transferMultiple(
        address[] calldata to,
        bytes32[] calldata tokenIDs,
        uint256[] calldata amounts
    )
        internal
    {
        // The current address in the calling contract.
        address from = address(this);

        // ABI encode the input parameters.
        bytes memory precompileData = abi.encodeCall(INativeTokens.transferMultiple, (from, to, tokenIDs, amounts));

        // Call the precompile, ignoring the response because the VM will panic if there's an issue.
        (bool response,) = PRECOMPILE_NATIVE_TOKENS.delegatecall(precompileData);
        response;
    }

    /// @notice Performs multiple native token transfers from the calling contract to the recipients `to`, and calls the
    /// `callee` with the calldata `data`.
    /// @dev Generates multiple Transfer receipts.
    ///
    /// Requirements:
    /// - The calling contract must have at least `amounts[i]` tokens for each token ID `tokenIDs[i]`.
    ///
    /// @param to The addresses of the recipients.
    /// @param tokenIDs The IDs of the native tokens to transfer.
    /// @param amounts The quantities of native tokens to transfer.
    /// @param callee The address of the contract to call after the transfer.
    /// @param data The call data to pass to the `callee`.
    function transferMultipleAndCall(
        address[] calldata to,
        bytes32[] calldata tokenIDs,
        uint256[] calldata amounts,
        address callee,
        bytes calldata data
    )
        internal
    {
        // The address in the calling contract.
        address from = address(this);

        // ABI encode the input parameters.
        bytes memory precompileData =
            abi.encodeCall(INativeTokens.transferMultipleAndCall, (from, to, tokenIDs, amounts, callee, data));

        // Call the precompile, ignoring the response because the VM will panic if there's an issue.
        (bool response,) = PRECOMPILE_NATIVE_TOKENS.delegatecall(precompileData);
        response;
    }
}