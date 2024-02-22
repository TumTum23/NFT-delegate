pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract DelegationContract is ERC721 {
    mapping(uint256 => address) public tokenDelegates;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

    function delegateNFT(uint256 tokenId, address delegatee) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "Caller is not owner nor approved");
        tokenDelegates[tokenId] = delegatee;
    }

    function revokeDelegation(uint256 tokenId) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "Caller is not owner nor approved");
        tokenDelegates[tokenId] = address(0);
    }

    function isDelegated(uint256 tokenId) public view returns (bool) {
        return tokenDelegates[tokenId] != address(0);
    }

    function useNFT(uint256 tokenId) public {
        require(tokenDelegates[tokenId] == _msgSender(), "Caller is not the delegatee");
    }
}