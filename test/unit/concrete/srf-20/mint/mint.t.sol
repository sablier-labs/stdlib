// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.26 <0.9.0;

import { ISRF20 } from "src/standards/srf-20/ISRF20.sol";
import { Base_Test } from "../../../../Base.t.sol";

contract Mint_Unit_Concrete_Test is Base_Test {
    function test_RevertWhen_TheRecipientIsTheZeroAddress() external {
        address recipient = address(0);
        vm.expectRevert(abi.encodeWithSelector(ISRF20.SRF20_InvalidRecipient.selector, recipient));
        usdc.mint({ recipient: recipient, amount: 1 });
    }

    modifier whenRecipientNotZeroAddress() {
        _;
    }

    function test_WhenTheRecipientIsNotTheZeroAddress() external whenRecipientNotZeroAddress {
        // TODO
        // it should mint the tokens
    }
}
