import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
ConnectivityStatus? checkStatus;

enum ConnectivityStatus{
  Wifi,
  Cellular,
  Offline
}

class ConnectivityService{

  StreamController<ConnectivityStatus> _status = StreamController<ConnectivityStatus>();

  ConnectivityService(){

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _status.add(_getResult(result));
    });

  }
}

ConnectivityStatus _getResult(ConnectivityResult result){
  switch(result){
    case ConnectivityResult.wifi:
      return ConnectivityStatus.Wifi;
    case ConnectivityResult.mobile:
      return ConnectivityStatus.Cellular;
    case ConnectivityResult.none:
      return ConnectivityStatus.Offline;
    default:
      return ConnectivityStatus.Offline;

  }
}

final statusProvider = StreamProvider<ConnectivityStatus>((ref) => ConnectivityService()._status.stream);
