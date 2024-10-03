//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployMoodNft is Script {
    function run() public returns (MoodNft) {
        string memory SAD_SVG_IMAGE = vm.readFile("./img/sad.svg");
        string memory HAPPY_SVG_IMAGE = vm.readFile("./img/happy.svg");

        vm.startBroadcast();
        /*    MoodNft moodNft = new MoodNft(
            svgToImageURL(HAPPY_SVG_IMAGE),
            svgToImageURL(SAD_SVG_IMAGE)
        ); */
        MoodNft moodNft = new MoodNft();

        ERC1967Proxy proxy = new ERC1967Proxy(
            address(moodNft),
            abi.encodeWithSelector(
                MoodNft.initialize.selector, svgToImageURL(HAPPY_SVG_IMAGE), svgToImageURL(SAD_SVG_IMAGE)
            )
        );
        MoodNft moodNftProxy = MoodNft(address(proxy));
        vm.stopBroadcast();
        return moodNftProxy;
    }

    function svgToImageURL(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
