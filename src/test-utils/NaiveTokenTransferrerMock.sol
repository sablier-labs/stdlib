// SPDX-License-Identifier: MIT
pragma solidity >=0.8.12;

import { NativeTokens } from "../precompiles/native-tokens/NativeTokens.sol";

/// @notice Dummy mock contract for testing the individual- and multi-token transfer functionalities
contract NaiveTokenTransferrerMock {
    using NativeTokens for address;

    function getBalanceOfToken(address account, uint256 tokenID) external view returns (uint256) {
        return account.balanceOf(tokenID);
    }

    function getCallValues() external payable returns (uint256[] memory, uint256[] memory) {
        // TODO: make the getCallValues() function callable directly from the Precompile, w/o having to call it on an
        // address?
        return address(this).getCallValues();
    }

    function transfer(address to, uint256 tokenID, uint256 amount) external {
        to.transfer(tokenID, amount);
    }

    function transferAndCall(
        address recipientAndCallee,
        uint256 tokenID,
        uint256 amount,
        bytes calldata data
    )
        external
    {
        recipientAndCallee.transferAndCall(tokenID, amount, data);
    }

    function transferMultiple(address to, uint256[] calldata tokenIDs, uint256[] calldata amounts) external {
        to.transferMultiple(tokenIDs, amounts);
    }

    function transferMultipleAndCall(
        address recipientAndCallee,
        uint256[] calldata tokenIDs,
        uint256[] calldata amounts,
        bytes calldata data
    )
        external
    {
        recipientAndCallee.transferMultipleAndCall(tokenIDs, amounts, data);
    }
}
