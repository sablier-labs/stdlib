// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.26 <0.9.0;

import { Base_Test } from "../../../Base.t.sol";

contract Decimals_Unit_Concrete_Test is Base_Test {
    function test_Decimals() external view {
        uint8 actualDecimals = usdc.decimals();
        uint8 expectedDecimals = NATIVE_TOKEN_DECIMALS;
        assertEq(actualDecimals, expectedDecimals, "decimals");
    }
}
