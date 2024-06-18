import 'package:app/services/orb_attestation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:rly_network_flutter_sdk/rly_network_flutter_sdk.dart';
import 'package:rly_network_flutter_sdk/rly_network_flutter_sdk.dart'
    as rly_network;
import 'package:app/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orb Attestation Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Orb Attestation Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _txHash = "";

  Future<void> callOrbAtestation() async {
    // test values

    EthereumAddress token =
        EthereumAddress.fromHex("0x41e94eb019c0762f9bfcf9fb1e58725bfb0e7582");
    BigInt fromProfileId = BigInt.from(702);
    EthereumAddress from =
        EthereumAddress.fromHex("0xfebc231959550ffecd1ad1ae22a3d6bb55471b6a");
    BigInt toProfileId = BigInt.from(246);
    EthereumAddress to =
        EthereumAddress.fromHex("0x16a88c2c2285d609f703cb6970c2f96a84e722ec");
    BigInt amount = BigInt.from(10);
    const String contentUri =
        "ar://Vqspq5PLryNC_2yAL80TwoKcwtk1uCTcCs7JJRENRqk";
    BigInt erc721Id = BigInt.from(0);
    const bool isErc20 = true;

    var httpClient = Client();

    final rlyNetwork = rly_network.rlyAmoyNetwork;
    rlyNetwork.setApiKey(Constants.rlyApiKey);

    EthereumAddress walletAddress;

    String? address = await WalletManager.getInstance().getPublicAddress();

    if (address != null) {
      walletAddress = EthereumAddress.fromHex(address);
    } else {
      rly_network.Wallet wallet =
          await WalletManager.getInstance().createWallet();
      walletAddress = wallet.address;
    }

    debugPrint("wallet address $walletAddress");

    final provider = Web3Client(Constants.rpcURL, httpClient);

    final OrbAttestation orbAttestation = OrbAttestation(
        EthereumAddress.fromHex(Constants.orbAttestationWrapperAddress),
        walletAddress,
        provider);

    final gsnTx = await orbAttestation.getOrbAttestationTx(token, fromProfileId,
        from, toProfileId, to, amount, contentUri, erc721Id, isErc20);

    final String txHash = await rlyNetwork.relay(gsnTx);
    _txHash = txHash;
    debugPrint('tx hash $txHash');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Transaction Hash',
            ),
            Text(
              _txHash,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            FullWidthButton(
              onPressed: callOrbAtestation,
              child: const Text('Call Orb Attestation'),
            ),
          ],
        ),
      ),
    );
  }
}

class FullWidthButton extends MaterialButton {
  const FullWidthButton({
    Key? key,
    required VoidCallback onPressed,
    required Widget child,
  }) : super(
          key: key,
          onPressed: onPressed,
          child: child,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
