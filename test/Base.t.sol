// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.26 <0.9.0;

import { Test } from "forge-std/src/Test.sol";

import { SRF20Mock } from "./../src/standards/srf-20/SRF20Mock.sol";

import { Constants } from "./utils/Constants.sol";
import { Defaults } from "./utils/Defaults.sol";
import { Users } from "./utils/Types.sol";

/// @notice Base test contract with common logic needed by all tests.
abstract contract Base_Test is Constants, Test {
    /*//////////////////////////////////////////////////////////////////////////
                                     VARIABLES
    //////////////////////////////////////////////////////////////////////////*/

    Users internal users;

    /*//////////////////////////////////////////////////////////////////////////
                                   TEST CONTRACTS
    //////////////////////////////////////////////////////////////////////////*/

    Defaults internal defaults;
    SRF20Mock internal usdc;

    /*//////////////////////////////////////////////////////////////////////////
                                  SET-UP FUNCTION
    //////////////////////////////////////////////////////////////////////////*/

    function setUp() public virtual {
        // Deploy the base test contracts.
        usdc = new SRF20Mock({ name: USDC_NAME, symbol: USDC_SYMBOL });

        // Label the base test contracts.
        vm.label({ account: address(usdc), newLabel: "USDC" });

        // Deploy the defaults contract.
        defaults = new Defaults();
        defaults.setToken(usdc);

        // Create users for testing.
        users.alice = createUser("Alice");
        defaults.setUsers(users);

        // Warp to June 1, 2024 at 00:00 GMT to provide a more realistic testing environment.
        vm.warp({ newTimestamp: JUNE_1_2024 });
    }

    /*//////////////////////////////////////////////////////////////////////////
                                      HELPERS
    //////////////////////////////////////////////////////////////////////////*/

    /// @dev Generates a user and labels its address.
    function createUser(string memory name) internal returns (address payable) {
        address payable user = payable(makeAddr(name));
        // TODO: dealing requires https://github.com/sablier-labs/stdlib/issues/6
        // vm.deal({ account: user, newBalance: 100 ether });
        return user;
    }

    /// @dev Derives the token ID from the contract's address and the default sub ID.
    function getTokenID(SRF20Mock tokenContract) internal view returns (uint256) {
        // Concatenate the contract's address and the default sub ID.
        bytes memory concatenation = abi.encodePacked(address(tokenContract), defaults.SUB_ID());

        // Hash the concatenated value.
        bytes32 hashed = keccak256(concatenation);

        // Wrap the resultant hash into the expected type.
        return uint256(hashed);
    }
}
