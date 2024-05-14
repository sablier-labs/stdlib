// SPDX-License-Identifier: MIT
pragma solidity >=0.8.12;

/// @notice Interface for the SRF20 standard, which implements a Single Native Token.
/// @dev See https://github.com/sablier-labs/SRFs
interface ISRF20 {
    /*//////////////////////////////////////////////////////////////////////////
                                       ERRORS
    //////////////////////////////////////////////////////////////////////////*/

    /// @notice Indicates a failure with a holder address when tokens are burned.
    error SRF20_InvalidHolder(address holder);

    /// @notice Indicates a failure with a recipient address when tokens are minted
    error SRF20_InvalidRecipient(address recipient);

    /*//////////////////////////////////////////////////////////////////////////
                                     FUNCTIONS
    //////////////////////////////////////////////////////////////////////////*/

    /// @notice Returns the number of decimals used to get the token's user representation.
    /// In SabVM, this value is always 18 in order to imitate the relationship between Ether and Wei.
    function decimals() external pure returns (uint8);

    /// @notice Returns the ID of the Native Token minted by the contract.
    /// @dev The default sub ID of 0 is used to generate the ID.
    function ID() external view returns (uint256);

    /// @notice Returns the name of the token.
    function name() external view returns (string memory);

    /// @notice Returns the symbol of the token.
    function symbol() external view returns (string memory);

    /// @notice Returns the total supply of tokens in circulation.
    function totalSupply() external view returns (uint256);
}
