part of 'floor_map_bloc.dart';

abstract class FloorMapEvent extends Equatable {
  const FloorMapEvent();

  @override
  List<Object?> get props => [];
}

class FetchTablesEvent extends FloorMapEvent {
  const FetchTablesEvent();
}

class ChangeLocationEvent extends FloorMapEvent {
  final LocationEntity newLocation;

  const ChangeLocationEvent(this.newLocation);

  @override
  List<Object?> get props => [newLocation];
}

class RefreshTableStatusEvent extends FloorMapEvent {
  const RefreshTableStatusEvent();
}