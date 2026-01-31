import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/network/network_info.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final NetworkInfo networkInfo;
  StreamSubscription? _connectivitySubscription;

  ConnectivityBloc({required this.networkInfo}) : super(const ConnectivityState()) {

    _connectivitySubscription = networkInfo.onStatusChange.listen((ConnectivityStatus status) {
      add(OnConnectivityChangedEvent(status));
    });

    on<OnConnectivityChangedEvent>((event, emit) {
      if (event.status == ConnectivityStatus.connected) {
        emit(const ConnectivityState(status: ConnectivityStatus.connected));
      } else {
        emit(const ConnectivityState(status: ConnectivityStatus.disconnected));
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}