import 'package:check_internet/connectivity_wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Check Internet Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Check Internet Demo'),
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
            const ConnectivityService(
                hasInternet: Text('Ada intermet'),
                noInternet: Text('Takda internet')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SecondPage()));
                },
                child: const Text('Next Page')),
            // CheckInternet(
            //   hasInternet: const Text('Has internet'),
            //   onHasInternet: () {
            //     //Do Something
            //     var snackBar = const SnackBar(content: Text('You are online'));
            //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //   },
            //   noInternet: const Text('No internet'),
            //   onNoInternet: () {
            //     //Do Something
            //     var snackBar = const SnackBar(content: Text('You are offline'));
            //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //   },
            // ),
            // CheckInternet(
            //   hasInternet: const Text('Has internet 2'),
            //   onHasInternet: () {
            //     //Do Something
            //     var snackBar =
            //         const SnackBar(content: Text('You are online 2'));
            //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //   },
            //   noInternet: const Text('No internet 2'),
            //   onNoInternet: () {
            //     //Do Something
            //     var snackBar = const SnackBar(content: Text('You are offline'));
            //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
