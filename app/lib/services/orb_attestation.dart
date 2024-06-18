import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:convert';
import 'package:app/contracts/orb_attestation_abi.dart';
import 'package:rly_network_flutter_sdk/src/gsn/utils.dart';

class OrbAttestation {
  final EthereumAddress contractAddress;
  final EthereumAddress accountAddress;
  final Web3Client provider;

  OrbAttestation(this.contractAddress, this.accountAddress, this.provider);

  Future getOrbAttestationTx(tokenAddress, fromProfileId, from, toProfileId, to,
      amount, contentUri, erc721Id, isERC20) async {
    final abi = getOrbAttestationJson()['abi'];

    final orbAttestation = DeployedContract(
      ContractAbi.fromJson(jsonEncode(abi), 'OrbAttestationWrapper'),
      contractAddress,
    );

    final tx = orbAttestation.function("transfer").encodeCall([
      tokenAddress,
      fromProfileId,
      from,
      toProfileId,
      to,
      amount,
      contentUri,
      erc721Id,
      isERC20
    ]);

    final gas = await provider.estimateGas(
      sender: accountAddress,
      data: tx,
      to: contractAddress,
    );

    final info = await provider.getBlockInformation();

    final BigInt maxPriorityFeePerGas = BigInt.parse("1500000000");
    final maxFeePerGas =
        info.baseFeePerGas!.getInWei * BigInt.from(2) + (maxPriorityFeePerGas);

    final gsnTx = GsnTransactionDetails(
      from: accountAddress.hex,
      data: '0x${bytesToHex(tx)}',
      value: "0",
      to: contractAddress.hex,
      gas: "0x${gas.toRadixString(16)}",
      maxFeePerGas: maxFeePerGas.toString(),
      maxPriorityFeePerGas: maxPriorityFeePerGas.toString(),
    );

    return gsnTx;
  }
}
