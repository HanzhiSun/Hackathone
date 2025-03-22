// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LuxuryAuthenticity is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;
    mapping(uint256 => string) public authenticityCodes;

    constructor() ERC721("LuxuryAuthenticity", "LUX") {}

    // Only the manufacturer (contract owner) can mint
    function mintAuthenticItem(address recipient, string memory tokenURI, string memory authCode) public onlyOwner returns (uint256) {
        _tokenIds++;
        uint256 newItemId = _tokenIds;
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);
        authenticityCodes[newItemId] = authCode;
        return newItemId;
    }

    // Public verification function
    function verifyAuthenticity(uint256 tokenId, string memory authCode) public view returns (bool) {
        return keccak256(abi.encodePacked(authenticityCodes[tokenId])) == keccak256(abi.encodePacked(authCode));
    }
}
