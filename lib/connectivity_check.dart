import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { NotDetermined, On, Off }

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  StreamController<ConnectivityResult> controller =
  StreamController<ConnectivityResult>();

 late NetworkStatus lastResult;


  NetworkDetectorNotifier() : super(NetworkStatus.Off) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
        state = NetworkStatus.On;
      }else{
        state = NetworkStatus.Off;
      }

    });
  }
}

final networkAwareProvider = StateNotifierProvider<NetworkDetectorNotifier, NetworkStatus>((ref) {
  return NetworkDetectorNotifier();
});