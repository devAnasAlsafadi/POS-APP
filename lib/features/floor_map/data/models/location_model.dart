import '../../domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.id,
    required super.locationName,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] ?? 0,
      locationName: json['location'] ?? 'Unknown Location',
    );
  }

  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      locationName: locationName,
    );
  }




}