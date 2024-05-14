// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.26 <0.9.0;

import { ISRF20 } from "src/standards/srf-20/ISRF20.sol";
import { Base_Test } from "../../../../Base.t.sol";

contract Burn_Unit_Concrete_Test is Base_Test {
    function test_RevertWhen_TheHolderIsTheZeroAddress() external {
        address holder = address(0);
        vm.expectRevert(abi.encodeWithSelector(ISRF20.SRF20_InvalidHolder.selector, holder));
        usdc.burn({ holder: holder, amount: 1 });
    }

    modifier whenHolderNotZeroAddress() {
        _;
    }

    function test_WhenTheHolderIsNotTheZeroAddress() external whenHolderNotZeroAddress {
        // TODO
        // it should burn the tokens
    }
}
