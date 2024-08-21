// SPDX-License-Identifier: MIT
pragma solidity >=0.8.12;

/// @notice Interface for the NativeTokens precompile, which can perform operations on native tokens.
/// @dev It is NOT recommended to use this interface directly. Instead, users should use the {NativeTokens} library.
/// This interface is used by the library to ABI encode the precompile calls.
interface INativeTokens {
    function balanceOf(address account, uint256 tokenID) external returns (uint256);
    function burn(uint256 subID, address holder, uint256 amount) external;

    // TODO: implement `callvalues()`

    function mint(uint256 subID, address recipient, uint256 amount) external;
    function transfer(address to, uint256 tokenID, uint256 amount) external;
    function transferAndCall(
        address recipientAndCallee,
        uint256 tokenID,
        uint256 amount,
        bytes calldata data
    )
        external;
    function transferMultiple(address to, uint256[] calldata tokenIDs, uint256[] calldata amounts) external;
    function transferMultipleAndCall(
        address recipientAndCallee,
        uint256[] calldata tokenIDs,
        uint256[] calldata amounts,
        bytes calldata data
    )
        external;
}
