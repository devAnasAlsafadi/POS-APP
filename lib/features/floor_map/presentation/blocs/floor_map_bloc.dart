import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/location_entity.dart';
import '../../domain/entities/table_entity.dart';
import '../../domain/usecases/get_tables_usecase.dart';

part 'floor_map_event.dart';
part 'floor_map_state.dart';

class FloorMapBloc extends Bloc<FloorMapEvent, FloorMapState> {
  final GetTablesUseCase getTablesUseCase;

  FloorMapBloc({required this.getTablesUseCase}) : super(FloorMapState()) {
    on<FetchTablesEvent>(_onFetchTables);
    on<ChangeLocationEvent>(_onChangeLocation);
  }





  Future<void> _onFetchTables(FetchTablesEvent event, Emitter<FloorMapState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getTablesUseCase();

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
          (tables) {
        final allLocations = tables
            .where((t) => t.location != null)
            .map((t) => t.location!)
            .toSet()
            .toList();

        final defaultLocation = allLocations.isNotEmpty ? allLocations.first : null;

        final filtered = tables.where((t) => t.locationId == defaultLocation?.id).toList();

        emit(state.copyWith(
          isLoading: false,
          allTables: tables,
          locations: allLocations,
          filteredTables: filtered,
          selectedLocation: defaultLocation,
        ));
      },
    );
  }

  void _onChangeLocation(ChangeLocationEvent event, Emitter<FloorMapState> emit) {
    final filtered = state.allTables.where((t) => t.locationId == event.newLocation.id).toList();
    emit(state.copyWith(
      selectedLocation: event.newLocation,
      filteredTables: filtered,
    ));
  }
}
