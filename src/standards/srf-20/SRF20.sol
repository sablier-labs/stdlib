// SPDX-License-Identifier: MIT
pragma solidity >=0.8.12;

import { DEFAULT_SUB_ID } from "../../Constants.sol";
import { NativeTokens } from "../../precompiles/native-tokens/NativeTokens.sol";
import { ISRF20 } from "./ISRF20.sol";

abstract contract SRF20 is ISRF20 {
    using NativeTokens for address;

    /*//////////////////////////////////////////////////////////////////////////
                                  STATE VARIABLES
    //////////////////////////////////////////////////////////////////////////*/

    /// @notice The SRF-20 name of the token.
    string private _name;

    /// @notice The SRF-20 symbol of the token.
    string private _symbol;

    /// @notice The total amount of tokens in circulation.
    uint256 public override totalSupply;

    /*//////////////////////////////////////////////////////////////////////////
                                     CONSTRUCTOR
    //////////////////////////////////////////////////////////////////////////*/

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /*//////////////////////////////////////////////////////////////////////////
                           USER-FACING CONSTANT FUNCTIONS
    //////////////////////////////////////////////////////////////////////////*/

    /// @notice Returns the number of decimals used to get the token's user representation.
    /// In SabVM, this value is always 18 in order to imitate the relationship between Ether and Wei.
    function decimals() external pure override returns (uint8) {
        return 18;
    }

    /// @notice Returns the ID of the Native Token minted by the contract.
    /// @dev The default sub ID of 0 is used to generate the ID.
    function ID() external view override returns (uint256) {
        // Concatenate the contract's address and the default sub ID.
        bytes memory concatenation = abi.encodePacked(address(this), DEFAULT_SUB_ID);

        // Hash the concatenated value.
        bytes32 hashed = keccak256(concatenation);

        // Wrap the resultant hash into the expected type.
        return uint256(hashed);
    }

    /// @notice Returns the name of the token.
    function name() external view override returns (string memory) {
        return _name;
    }

    /// @notice Returns the symbol of the token.
    function symbol() external view override returns (string memory) {
        return _symbol;
    }

    /*//////////////////////////////////////////////////////////////////////////
                           INTERNAL CONSTANT FUNCTIONS
    //////////////////////////////////////////////////////////////////////////*/

    /// @notice Burns `amount` tokens from the provided `holder`, and decreases the token supply.
    ///
    /// @dev Requirements:
    ///
    /// - Refer to the requirements in {NativeTokens-burn}.
    function _burn(address holder, uint256 amount) internal {
        // Checks: `holder` is not the zero address.
        if (holder == address(0)) {
            revert ISRF20.SRF20_InvalidHolder(holder);
        }

        // Native Interactions: burn the tokens via the SabVM precompile.
        holder.burn(DEFAULT_SUB_ID, amount);

        // Effects: reduce the total supply.
        unchecked {
            // Underflow not possible: the precompile would have panicked if the holder's balance underflowed.
            totalSupply -= amount;
        }
    }

    /// @notice Mints `amount` tokens to the provided `recipient`, and increases the total supply.
    ///
    /// @dev Requirements:
    ///
    /// - Refer to the requirements in {NativeTokens-mint}.
    /// - The total supply must not overflow.
    function _mint(address recipient, uint256 amount) internal {
        // Checks: `beneficiary` is not the zero address.
        if (recipient == address(0)) {
            revert ISRF20.SRF20_InvalidRecipient(recipient);
        }

        // Native Interactions: mint the new tokens via the SabVM precompile.
        recipient.mint(DEFAULT_SUB_ID, amount);

        // Effects: increase the total supply.
        totalSupply += amount;
    }
}
