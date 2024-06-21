// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "gsn/packages/contracts/src/BaseRelayRecipient.sol";
import {IOrbAttestation} from "./interfaces/IOrbAttestation.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";



// wrapper contract to call OrbAttestation contract with contract that supports RallyTransact gasless transactions

contract OrbAttestationWrapper is BaseRelayRecipient {
    string public override versionRecipient = "0.0.1+orbattessationwrapper";
    address orbAttestationAddress;
    uint256 fee; // fee as a percentage, 2 = 2%
    address adminWallet;
    constructor(address forwarder, address _orbAttestationAddress, address _adminWallet, uint256 _fee) {
        require(_fee <= 100, "Fee percentage cannot be more than 100");
        _setTrustedForwarder(forwarder);
        orbAttestationAddress = _orbAttestationAddress;
        adminWallet = _adminWallet;
        fee = _fee;
    }
    function transfer(address token, uint256 fromProfileId, address from, uint256 toProfileId, address to, uint256 amount, string calldata contentURI, uint256 erc721Id, bool isERC20) external {
        if(isERC20){
        uint256 transferFee = (amount * fee) / 100;
        require(IERC20(token).balanceOf(_msgSender()) >= amount + transferFee, "Insufficient balance for transfer + fee");
        IERC20(token).transferFrom(_msgSender(), adminWallet, transferFee);
        IOrbAttestation(orbAttestationAddress).transfer(token, fromProfileId, from, toProfileId, to, amount, contentURI, erc721Id, isERC20);
     }
    }
}