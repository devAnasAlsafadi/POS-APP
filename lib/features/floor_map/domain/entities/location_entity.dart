import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final int id;
  final String locationName;

  const LocationEntity({required this.id, required this.locationName});

  @override
  List<Object?> get props => [id, locationName];
}