// SPDX-License-Identifier: MIT
pragma solidity >=0.8.12;

import { NativeTokens } from "../../precompiles/native-tokens/NativeTokens.sol";

/// @notice Dummy mock contract for testing the individual- and multi-token transfer functionalities
contract NaiveTokenTransferrerMock {
    using NativeTokens for address;

    function transfer(address to, uint256 tokenID, uint256 amount) external {
        to.transfer(tokenID, amount);
    }

    function transferMultiple(address to, uint256[] calldata tokenIDs, uint256[] calldata amounts) external {
        to.transferMultiple(tokenIDs, amounts);
    }
}
