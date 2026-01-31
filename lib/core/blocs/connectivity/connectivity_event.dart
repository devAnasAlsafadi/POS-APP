part of 'connectivity_bloc.dart';

sealed class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class OnConnectivityChangedEvent extends ConnectivityEvent {
  final ConnectivityStatus status;
  const OnConnectivityChangedEvent(this.status);

  @override
  List<Object> get props => [status];
}

