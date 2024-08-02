//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    error MoodNft_CantFilpMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_sadSvg;
    string private s_happySvg;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private tokenIdToMood;

    constructor(
        string memory happysvg,
        string memory sadsvg
    ) ERC721("MoodNfts", "MNFTs") {
        s_tokenCounter = 0;
        s_sadSvg = sadsvg;
        s_happySvg = happysvg;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function filpMood(uint256 tokenId) public {
        if (
            getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender
        ) {
            revert MoodNft_CantFilpMoodIfNotOwner();
        }
        if (tokenIdToMood[tokenId] == Mood.HAPPY) {
            tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURL;

        if (tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURL = s_happySvg;
        } else {
            imageURL = s_sadSvg;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                            abi.encodePacked(
                                '{"name":"',
                                name(), // You can add whatever name here
                                '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                                '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageURL,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
