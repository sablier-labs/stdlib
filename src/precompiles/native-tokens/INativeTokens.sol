// SPDX-License-Identifier: MIT
pragma solidity >=0.8.12;

/// @notice Interface for the NativeTokens precompile, which can perform operations on native tokens.
/// @dev It is NOT recommended to use this interface directly. Instead, users should use the {NativeTokens} library.
/// This interface is used by the library to ABI encode the precompile calls.
interface INativeTokens {
    function balanceOf(uint256 tokenID, address account) external returns (uint256);
    function burn(address holder, bytes32 subID, uint256 amount) external;
    function mint(address recipient, bytes32 subID, uint256 amount) external;
    function transfer(address from, address to, bytes32 tokenID, uint256 amount) external;
    function transferAndCall(
        address from,
        address to,
        bytes32 tokenID,
        uint256 amount,
        address callee,
        bytes calldata data
    )
        external;
    function transferMultiple(
        address from,
        address[] calldata to,
        bytes32[] calldata tokenIDs,
        uint256[] calldata amounts
    )
        external;
    function transferMultipleAndCall(
        address from,
        address[] calldata to,
        bytes32[] calldata tokenIDs,
        uint256[] calldata amounts,
        address callee,
        bytes calldata data
    )
        external;
}
