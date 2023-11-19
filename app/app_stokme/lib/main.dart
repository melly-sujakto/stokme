import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stokme/firebase_options.dart';

bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await _initFirebaseCore();
  auth = FirebaseAuth.instanceFor(app: app);

  if (shouldUseFirebaseEmulator) {
    await auth.useAuthEmulator('localhost', 9099);
  }
  runApp(const MyApp());
}

Future<FirebaseApp> _initFirebaseCore() async {
  return Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: FirstTimeScreen.routeName,
      routes: {
        FirstTimeScreen.routeName: (context) => const FirstTimeScreen(),
        MyHomePage.routeName: (context) => const MyHomePage(title: 'Stokme'),
      },
    );
  }
}

class FirstTimeScreen extends StatelessWidget {
  static const routeName = 'firstTimeScreen';
  const FirstTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text('hallo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = 'myHomePage';

  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MobileScannerController cameraController =
      MobileScannerController(facing: CameraFacing.front);
  String code = '';

  dynamic product;

  Future<void> getAllData() async {
    final collectionRef = FirebaseFirestore.instance.collection('store');
    final querySnapshot = await collectionRef.get();
    setState(() {
      product = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> getOneData(String code) async {
    final collectionRef = FirebaseFirestore.instance.collection('product');
    final querySnapshot = await collectionRef.doc(code).get();
    setState(() {
      product = querySnapshot.data();
    });
  }

  final player = AudioPlayer();

  @override
  Future<void> dispose() async {
    await player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front, color: Colors.grey);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear, color: Colors.grey);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              SizedBox(
                width: constraints.maxWidth >= 1200
                    ? constraints.maxWidth / 2
                    : constraints.maxWidth,
                child: StreamBuilder<User?>(
                  stream: auth.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const Text('Authenticated');
                    }
                    return const Text('UnAuthenticated');
                  },
                ),
              ),
              TextButton(
                onPressed: () async {
                  await auth.signInWithEmailAndPassword(
                    email: 'melly.sujakto@gmail.com',
                    password: 'Stokmemelly123*',
                  );
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () async {
                  await auth.signOut();
                },
                child: const Text('Logout'),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.3,
                width: MediaQuery.sizeOf(context).width,
                child: MobileScanner(
                  fit: BoxFit.contain,
                  controller: cameraController,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      player
                        ..setVolume(1)
                        ..play(
                          AssetSource('audio/scanner_beep.mp3'),
                        );
                      setState(() {
                        if (barcode.rawValue != null) {
                          code = barcode.rawValue!;
                          getOneData(code);
                        }
                      });
                      debugPrint('Barcode found! ${barcode.rawValue}');
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  width: MediaQuery.sizeOf(context).width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          code.isEmpty ? '' : 'Product Code: $code',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (product != null)
                          Text(
                            'Product Name: ${product['name']}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        if (product != null)
                          Text(
                            'Price: Rp.${product['sale_net']}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
