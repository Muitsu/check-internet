import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckInternet extends StatefulWidget {
  final Widget? noInternet;
  final Widget hasInternet;
  final void Function()? onHasInternet;
  final void Function()? onNoInternet;
  const CheckInternet(
      {super.key,
      this.noInternet,
      required this.hasInternet,
      this.onHasInternet,
      this.onNoInternet});

  @override
  State<CheckInternet> createState() => _CheckInternetState();
}

class _CheckInternetState extends State<CheckInternet> {
  int _initConnection = 0;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    if (_connectionStatus == ConnectivityResult.none) {
      if (_initConnection == 0) {
        _initConnection++;
        return;
      }
      if (widget.onNoInternet != null) {
        widget.onNoInternet!();
      }
    } else if (_connectionStatus == ConnectivityResult.wifi) {
      if (_initConnection == 0) {
        _initConnection++;
        return;
      }
      if (widget.onHasInternet != null) {
        widget.onHasInternet!();
      }
    } else if (_connectionStatus == ConnectivityResult.mobile) {
      if (_initConnection == 0) {
        _initConnection++;
        return;
      }
      if (widget.onHasInternet != null) {
        widget.onHasInternet;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus == ConnectivityResult.none) {
      return widget.noInternet ?? const SizedBox.shrink();
    } else if (_connectionStatus == ConnectivityResult.wifi) {
      return widget.hasInternet;
    } else if (_connectionStatus == ConnectivityResult.mobile) {
      return widget.hasInternet;
    } else {
      return const SizedBox.shrink();
    }
  }
}
