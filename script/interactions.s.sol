// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MoodNft} from "src/MoodNft.sol";

contract MintMoodNft is Script {
    function run() public {
        address mostRecentydepolyd = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        mintNftOnContract(mostRecentydepolyd);
        filpMood(mostRecentydepolyd);
    }

    function mintNftOnContract(address mostRecentydepolyd) public {
        vm.startBroadcast();
        MoodNft(mostRecentydepolyd).mintNft();
        vm.stopBroadcast();
    }

    function filpMood(address mostRecentydepolyd) public {
        vm.startBroadcast();
        MoodNft(mostRecentydepolyd).filpMood(0);
        vm.stopBroadcast();
    }
}
