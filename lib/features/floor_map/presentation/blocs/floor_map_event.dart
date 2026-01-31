part of 'floor_map_bloc.dart';

abstract class FloorMapEvent extends Equatable {
  const FloorMapEvent();

  @override
  List<Object> get props => [];
}

class GetTablesEvent extends FloorMapEvent {}