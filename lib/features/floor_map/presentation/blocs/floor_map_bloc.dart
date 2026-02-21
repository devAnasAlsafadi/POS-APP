import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_wiz_tech/core/developer.dart';

import '../../../reservations/domain/entities/reservation_entity.dart';
import '../../../reservations/presentation/blocs/reservations_bloc.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/entities/table_entity.dart';
import '../../domain/usecases/get_tables_usecase.dart';

part 'floor_map_event.dart';
part 'floor_map_state.dart';

class FloorMapBloc extends Bloc<FloorMapEvent, FloorMapState> {
  final GetTablesUseCase getTablesUseCase;
  final ReservationsBloc reservationsBloc;
  StreamSubscription? _reservationsSubscription;

  FloorMapBloc({
    required this.getTablesUseCase,
    required this.reservationsBloc,
  }) : super(FloorMapState()) {
    on<FetchTablesEvent>(_onFetchTables);
    on<ChangeLocationEvent>(_onChangeLocation);
    on<RefreshTableStatusEvent>(_onRefreshTableStatus);





    _reservationsSubscription = reservationsBloc.stream.listen((resState) {
      if (resState is ReservationOperationSuccess || resState is ReservationsLoaded) {
        add(const FetchTablesEvent());
      }
    });



  }



  @override
  Future<void> close() {
    _reservationsSubscription?.cancel();
    return super.close();
  }


  Future<void> _onFetchTables(FetchTablesEvent event, Emitter<FloorMapState> emit) async {
     emit(state.copyWith(isLoading: true));
     final result = await getTablesUseCase();

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
          (success) {

            final  currentReservations = (reservationsBloc.state is ReservationsLoaded)
                ? (reservationsBloc.state as ReservationsLoaded).reservations
                : [];
            final mergedTables = success.data!.map((table) {
              final ReservationEntity? activeRes = currentReservations
                  .cast<ReservationEntity?>()
                  .firstWhere(
                    (res) => res?.tableId == table.id &&
                    res?.status.toLowerCase() == 'confirmed',
                orElse: () => null,
              );
              return table.copyWith(activeReservation: activeRes);
            }).toList();
            final allLocations = mergedTables
                .map((t) => t.location)
                .whereType<LocationEntity>()
                .toSet()
                .toList();

            LocationEntity? locationToUse = state.selectedLocation;
            if (allLocations.isNotEmpty) {
              if (state.selectedLocation == null) {
                locationToUse = allLocations.first;
              } else {

                locationToUse = allLocations.firstWhere(
                      (loc) => loc.id == state.selectedLocation!.id,
                  orElse: () => allLocations.first,
                );
              }
            }
            final filtered = mergedTables.where((t) => t.locationId == locationToUse?.id).toList();
            emit(state.copyWith(
              isLoading: false,
              allTables: mergedTables,
              filteredTables: filtered,
              locations: allLocations,
              selectedLocation: locationToUse,
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

  void _onRefreshTableStatus(RefreshTableStatusEvent event, Emitter<FloorMapState> emit) {
    final currentReservations = (reservationsBloc.state is ReservationsLoaded)
        ? (reservationsBloc.state as ReservationsLoaded).reservations
        : [];


    final mergedTables = state.allTables.map((table) {
      final activeRes = currentReservations.cast<ReservationEntity?>().firstWhere(
            (res) => res?.tableId == table.id &&
            (res?.status.toLowerCase() == 'confirmed' || res?.status.toLowerCase() == 'checked_in'),
        orElse: () => null,
      );
      return table.copyWith(activeReservation: activeRes);
    }).toList();


    final filtered = mergedTables.where((t) => t.locationId == state.selectedLocation?.id).toList();

    emit(state.copyWith(
      allTables: mergedTables,
      filteredTables: filtered,
    ));
  }
}
