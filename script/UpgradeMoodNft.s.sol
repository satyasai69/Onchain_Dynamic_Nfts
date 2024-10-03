// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {MoodNft} from "src/MoodNft.sol";
import {MoodNftV2} from "src/MoodNftV2.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract UpgradeMoodNft is Script {
    function run() public {
        //  string memory SAD_SVG_IMAGE = vm.readFile("./img/sad.svg");
        //   string memory HAPPY_SVG_IMAGE = vm.readFile("./img/happy.svg");

        address moodNft = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);
        vm.startBroadcast();
        MoodNftV2 moodNftV2 = new MoodNftV2();
        MoodNft proxy = MoodNft(payable(moodNft));
        proxy.upgradeTo(address(moodNftV2));
        /*    abi.encodeWithSelector(
                MoodNftV2.initialize.selector, svgToImageURL(HAPPY_SVG_IMAGE), svgToImageURL(SAD_SVG_IMAGE)
            )
        ); */

        vm.stopBroadcast();
    }

    function svgToImageURL(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
