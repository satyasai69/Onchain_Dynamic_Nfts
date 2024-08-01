//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MoodNfts is ERC721 {
    uint256 private s_tokenCounter;
    string private s_sadSvg;
    string private s_happySvg;
    mapping(uint256 => string) public tokenURIs;

    constructor(
        string memory sadsvg,
        string memory happysvg
    ) ERC721("MoodNfts", "MNFTs") {
        s_tokenCounter = 0;
        s_sadSvg = sadsvg;
        s_happySvg = happysvg;
    }
}
