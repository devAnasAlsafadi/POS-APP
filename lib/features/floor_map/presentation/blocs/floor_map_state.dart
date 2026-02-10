part of 'floor_map_bloc.dart';

 class FloorMapState extends Equatable {


  final List<TableEntity> allTables;
  final List<LocationEntity> locations;
  final List<TableEntity> filteredTables;
  final LocationEntity? selectedLocation;
  final String? errorMessage;
  final bool isLoading;

  const FloorMapState({
    this.allTables = const [],
    this.locations = const [],
    this.filteredTables = const [],
    this.selectedLocation,
    this.errorMessage,
    this.isLoading = false,
  });

  FloorMapState copyWith({
    List<TableEntity>? allTables,
    List<LocationEntity>? locations,
    List<TableEntity>? filteredTables,
    LocationEntity? selectedLocation,
    String? errorMessage,
    bool? isLoading,
  }) {
    return FloorMapState(
      allTables: allTables ?? this.allTables,
      locations: locations ?? this.locations,
      filteredTables: filteredTables ?? this.filteredTables,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [allTables, locations, filteredTables, selectedLocation, errorMessage, isLoading];

}
