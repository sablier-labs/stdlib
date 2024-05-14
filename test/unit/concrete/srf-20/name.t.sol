// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.26 <0.9.0;

import { Base_Test } from "../../../Base.t.sol";

contract Name_Unit_Concrete_Test is Base_Test {
    function test_Name() external view {
        string memory actualName = usdc.name();
        string memory expectedName = USDC_NAME;
        assertEq(actualName, expectedName, "name");
    }
}
