// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.8.26;

import { ISRF20 } from "./../../src/standards/srf-20/ISRF20.sol";

import { Constants } from "./Constants.sol";
import { Users } from "./Types.sol";

/// @notice Collection of default values used throughout the tests.
contract Defaults is Constants {
    /*//////////////////////////////////////////////////////////////////////////
                                  STATE VARIABLES
    //////////////////////////////////////////////////////////////////////////*/

    uint256 public constant BURN_AMOUNT = 2500e18;
    uint256 public constant MINT_AMOUNT = 10_000e18;
    bytes32 public constant SUB_ID = bytes32(0);

    ISRF20 private token;
    Users private users;

    /*//////////////////////////////////////////////////////////////////////////
                                      HELPERS
    //////////////////////////////////////////////////////////////////////////*/

    function setToken(ISRF20 token_) public {
        token = token_;
    }

    function setUsers(Users memory users_) public {
        users = users_;
    }
}
