// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin/token/ERC20/IERC20.sol";
import "openzeppelin/token/ERC721/IERC721.sol";
import "gsn/packages/contracts/src/ERC2771Recipient.sol";
import "./interfaces/ILensHub.sol";

// orb attestation contract that supports RallyTransact gasless transactions

contract OrbAttestationRallyTransact is ERC2771Recipient {
    event Attestation(uint256 fromProfileId, address from, uint256 toProfileId, address to, uint256 amount, address token, string contentURI);

    ILensHub public immutable lensHub;

    constructor(ILensHub _lensHub, address _forwarder) {
        lensHub = _lensHub;
        _setTrustedForwarder(_forwarder);
    }

    function transfer(address token, uint256 fromProfileId, address from, uint256 toProfileId, address to, uint256 amount, string calldata contentURI, uint256 erc721Id, bool isERC20) external {
        if (fromProfileId != 0 && IERC721(address(lensHub)).ownerOf(fromProfileId) != from && !lensHub.isDelegatedExecutorApproved(fromProfileId, from)) revert();
        if (toProfileId != 0 && IERC721(address(lensHub)).ownerOf(toProfileId) != to && !lensHub.isDelegatedExecutorApproved(toProfileId, to)) revert();
        
        if (isERC20) IERC20(token).transferFrom(from, to, amount);
        else IERC721(token).safeTransferFrom(from, to, erc721Id, new bytes(0));

        emit Attestation(fromProfileId, from, toProfileId, to, amount, token, contentURI);
    }
}