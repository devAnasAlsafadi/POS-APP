import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../blocs/connectivity/connectivity_bloc.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<ConnectivityStatus> get onStatusChange;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker dataConnectionChecker;

  NetworkInfoImpl(this.dataConnectionChecker);

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;

  @override
  Stream<ConnectivityStatus> get onStatusChange =>
      dataConnectionChecker.onStatusChange.map((status) {
        return status == InternetConnectionStatus.connected
            ? ConnectivityStatus.connected
            : ConnectivityStatus.disconnected;
      });
}