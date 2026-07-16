// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {ERC20Mock} from "../mocks/ERC20Mock.sol";

contract DSCEngineLiquidationTest is Test {
    DeployDSC public deployer;
    DSCEngine public dscEngine;
    DecentralizedStableCoin public dsc;
    HelperConfig public helperConfig;

    address public weth;
    address public USER = makeAddr("user");
    uint256 public constant AMOUNT_COLLATERAL = 10 ether;

    function setUp() public {
        deployer = new DeployDSC();
        (dsc, dscEngine, helperConfig) = deployer.run();
        (,, weth,,) = helperConfig.activeNetworkConfig();
    }

    function testLiquidationCheckRevertsIfUserIsHealthy() public {
        vm.startPrank(USER);
        ERC20Mock(weth).mint(USER, AMOUNT_COLLATERAL);
        ERC20Mock(weth).approve(address(dscEngine), AMOUNT_COLLATERAL);
        dscEngine.depositCollateralAndMintDsc(weth, AMOUNT_COLLATERAL, 100e18);
        vm.stopPrank();

        vm.expectRevert(DSCEngine.DSCEngine__HealthFactorOk.selector);
        dscEngine.liquidate(weth, USER, 10e18);
    }
}
