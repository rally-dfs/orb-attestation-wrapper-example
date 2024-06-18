Map<String, dynamic> getOrbAttestationJson() {
  return {
    "abi": [
      {
        "type": "constructor",
        "inputs": [
          {"name": "forwarder", "type": "address", "internalType": "address"},
          {
            "name": "_orbAttestationAddress",
            "type": "address",
            "internalType": "address"
          }
        ],
        "stateMutability": "nonpayable"
      },
      {
        "type": "function",
        "name": "getTrustedForwarder",
        "inputs": [],
        "outputs": [
          {"name": "forwarder", "type": "address", "internalType": "address"}
        ],
        "stateMutability": "view"
      },
      {
        "type": "function",
        "name": "isTrustedForwarder",
        "inputs": [
          {"name": "forwarder", "type": "address", "internalType": "address"}
        ],
        "outputs": [
          {"name": "", "type": "bool", "internalType": "bool"}
        ],
        "stateMutability": "view"
      },
      {
        "type": "function",
        "name": "transfer",
        "inputs": [
          {"name": "token", "type": "address", "internalType": "address"},
          {
            "name": "fromProfileId",
            "type": "uint256",
            "internalType": "uint256"
          },
          {"name": "from", "type": "address", "internalType": "address"},
          {"name": "toProfileId", "type": "uint256", "internalType": "uint256"},
          {"name": "to", "type": "address", "internalType": "address"},
          {"name": "amount", "type": "uint256", "internalType": "uint256"},
          {"name": "contentURI", "type": "string", "internalType": "string"},
          {"name": "erc721Id", "type": "uint256", "internalType": "uint256"},
          {"name": "isERC20", "type": "bool", "internalType": "bool"}
        ],
        "outputs": [],
        "stateMutability": "nonpayable"
      }
    ]
  };
}
