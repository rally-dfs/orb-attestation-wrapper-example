// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "gsn/packages/contracts/src/ERC2771Recipient.sol";
import {IOrbAttestation} from "./interfaces/IOrbAttestation.sol";


// wrapper contract to call OrbAttestation contract with contract that supports RallyTransact gasless transactions

contract OrbAttestationWrapper is ERC2771Recipient {
    address orbAttestationAddress;
    constructor(address forwarder, address _orbAttestationAddress) {
        _setTrustedForwarder(forwarder);
        orbAttestationAddress = _orbAttestationAddress;
    }
    function transfer(address token, uint256 fromProfileId, address from, uint256 toProfileId, address to, uint256 amount, string calldata contentURI, uint256 erc721Id, bool isERC20) external {
        IOrbAttestation(orbAttestationAddress).transfer(token, fromProfileId, from, toProfileId, to, amount, contentURI, erc721Id, isERC20);
    }
}
