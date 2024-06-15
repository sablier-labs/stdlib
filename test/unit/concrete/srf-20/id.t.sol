// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.26 <0.9.0;

import { Base_Test } from "../../../Base.t.sol";

contract ID_Unit_Concrete_Test is Base_Test {
    function test_ID() external view {
        uint256 actualID = usdc.ID();
        uint256 expectedID = getTokenID(usdc);
        assertEq(actualID, expectedID, "ID");
    }
}
