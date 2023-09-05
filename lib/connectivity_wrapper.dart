import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService extends StatelessWidget {
  final Widget hasInternet;
  final Widget? noInternet;
  const ConnectivityService(
      {super.key, required this.hasInternet, this.noInternet});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        // if (!snapshot.hasData) {
        //   return const CircularProgressIndicator();
        // }

        final connectivityResult = snapshot.data;

        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          return hasInternet;
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No internet connection'),
                duration: Duration(seconds: 3), // Adjust duration as needed
              ),
            );
          });
          return noInternet ?? hasInternet;
        }
      },
    );
  }
}
