// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DSCEngine} from "../src/DSCEngine.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract RedeemCollateral is Script {
    function run() external {
        HelperConfig helperConfig = new HelperConfig();
        (,, address weth,,) = helperConfig.activeNetworkConfig();

        console.log("RedeemCollateral script initialized for collateral address:", weth);
    }
}
