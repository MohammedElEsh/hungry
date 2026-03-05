import 'package:connectivity_plus/connectivity_plus.dart';

/// Contract for checking network connectivity.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Implementation using connectivity_plus.
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return results.isNotEmpty &&
        results.any((r) => r != ConnectivityResult.none);
  }
}
