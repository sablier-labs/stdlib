// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.26 <0.9.0;

import { Base_Test } from "../../../Base.t.sol";

contract Symbol_Unit_Concrete_Test is Base_Test {
    function test_Symbol() external view {
        string memory actualSymbol = usdc.symbol();
        string memory expectedSymbol = USDC_SYMBOL;
        assertEq(actualSymbol, expectedSymbol, "symbol");
    }
}
