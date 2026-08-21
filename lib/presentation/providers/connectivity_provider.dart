import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  bool isOffline = false;

  ConnectivityProvider() {
    init();
  }

  void init() {
    _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      if (results.contains(ConnectivityResult.none)) {
        isOffline = true;
      } else {
        isOffline = false;
      }
      notifyListeners();
    });
  }
}
