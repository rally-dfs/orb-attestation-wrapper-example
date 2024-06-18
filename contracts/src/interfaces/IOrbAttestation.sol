// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IOrbAttestation {
 function transfer(address token, uint256 fromProfileId, address from, uint256 toProfileId, address to, uint256 amount, string calldata contentURI, uint256 erc721Id, bool isERC20) external;

}