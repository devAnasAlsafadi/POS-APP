part of 'connectivity_bloc.dart';

enum ConnectivityStatus { initial, connected, disconnected }

class ConnectivityState extends Equatable {
  final ConnectivityStatus status;

  const ConnectivityState({this.status = ConnectivityStatus.initial});

  @override
  List<Object> get props => [status];
}