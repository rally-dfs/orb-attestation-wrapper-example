# Orb Attestation Wrapper Example

The purpose of this repo is to provide a quick example of how to wrap an existing contract to enable RallyTransact gasless transactions and then call the contract from a simple Flutter app. In this example we wrap the [Orb Attestation contract](https://amoy.polygonscan.com/address/0xC3CA7A773AE5B3FA974c6333e65AC468088A4B73) with a contract that supports RallyTransact gasless transactions. The contract wrapper is implemented in `/contracts/src/OrbAttestationWrapper.sol` and an example flutter app calling the contracts is at `/app`.

The example app calls the `transfer()` method on the Orb Attestation contract using the following test inputs.

```
{
  "token": "0x41e94eb019c0762f9bfcf9fb1e58725bfb0e7582",
  "fromProfileId": "702",
  "from": "0xfebc231959550ffecd1ad1ae22a3d6bb55471b6a",
  "toProfileId": "246",
  "to": "0x16a88c2c2285d609f703cb6970c2f96a84e722ec",
  "amount": "10",
  "contentURI": "ar://Vqspq5PLryNC_2yAL80TwoKcwtk1uCTcCs7JJRENRqk",
  "erc721Id": "0",
  "isERC20": true
}
```

An example test transaction showing successful contract execution can be found [here](https://amoy.polygonscan.com/tx/0xf2c4d403424a7d2702c322f4c3a9a46083a13c4994ad221f6032099b75463d40)

Note: there are two examples of supporting RallyTransact with the existing OrbAttestation contract. 1. `contracts/src/OrbAttestationWrapper` a wrapper contract that wraps the existing contract with a contract that supports RallyTransact 2. `contracts/src/OrbAttestationRallyTransact.sol` a contract that extends the existing Orb Attestation contract to support RallyTransact.
