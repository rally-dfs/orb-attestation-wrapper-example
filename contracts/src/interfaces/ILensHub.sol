// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13;

import {Types} from "./IBaseFeeCollectModule.sol";

interface ILensHub {
    function isFollowing(uint256 followerProfileId, uint256 followedProfileId) external view returns (bool);

    function follow(uint256 followerProfileId, uint256[] calldata idsOfProfilesToFollow, uint256[] calldata followTokenIds, bytes[] calldata datas) external returns (uint256[] memory);

    function changeDelegatedExecutorsConfig(uint256 delegatorProfileId, address[] calldata delegatedExecutors, bool[] calldata approvals) external;

    function setProfileMetadataURI(uint256 profileId, string calldata metadataURI) external;

    function isDelegatedExecutorApproved(uint256 delegatorProfileId, address delegateExecutor) external returns (bool);

    function post(Types.PostParams calldata postParams) external returns (uint256);
}