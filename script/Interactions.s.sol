// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {DSCEngine} from "../src/DSCEngine.sol";
import {DecentralizedStableCoin} from "../src/DecentralizedStableCoin.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract MintDscInteraction is Script {
    function mintDscOnMostRecentDeployment(uint256 amount) public {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "DSCEngine",
            block.chainid
        );
        mintDsc(mostRecentlyDeployed, amount);
    }

    function mintDsc(address dscEngineAddress, uint256 amount) public {
        vm.startBroadcast();
        DSCEngine(dscEngineAddress).mintDsc(amount);
        vm.stopBroadcast();
        console.log("Minted %s DSC", amount);
    }

    function run() external {
        mintDscOnMostRecentDeployment(100e18);
    }
}
