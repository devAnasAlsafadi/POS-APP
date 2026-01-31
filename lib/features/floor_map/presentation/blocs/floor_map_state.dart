part of 'floor_map_bloc.dart';

abstract class FloorMapState extends Equatable {
  const FloorMapState();

  @override
  List<Object> get props => [];
}

class FloorMapInitial extends FloorMapState {}

class FloorMapLoading extends FloorMapState {}

class FloorMapLoaded extends FloorMapState {
  final List<TableEntity> tables;
  const FloorMapLoaded(this.tables);

  @override
  List<Object> get props => [tables];
}

class FloorMapError extends FloorMapState {
  final String message;
  const FloorMapError(this.message);

  @override
  List<Object> get props => [message];
}

class FloorMapOffline extends FloorMapState {}