//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConverSVG() public view {
        string
            memory HAPPY_SVG_BASE = "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgZmlsbD0ieWVsbG93IiByPSI3OCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIzIi8+PGcgY2xhc3M9ImV5ZXMiPjxjaXJjbGUgY3g9IjcwIiBjeT0iODIiIHI9IjEyIi8+PGNpcmNsZSBjeD0iMTI3IiBjeT0iODIiIHI9IjEyIi8+PC9nPjxwYXRoIGQ9Im0xMzYuODEgMTE2LjUzYy42OSAyNi4xNy02NC4xMSA0Mi04MS41Mi0uNzMiIHN0eWxlPSJmaWxsOm5vbmU7IHN0cm9rZTogYmxhY2s7IHN0cm9rZS13aWR0aDogMzsiLz48L3N2Zz4=";
        string memory HAPPY_SVG = vm.readFile("./img/happy.svg");

        string memory convertedSVG = deployer.svgToImageURL(HAPPY_SVG);

        assert(
            keccak256(abi.encodePacked(convertedSVG)) ==
                keccak256(abi.encodePacked(HAPPY_SVG_BASE))
        );
    }
}
