

import '../../../floor_map/data/models/table_model.dart';
import '../../domain/entities/reservation_entity.dart';

class ReservationModel extends ReservationEntity {
  const ReservationModel({
    required super.id,
    required super.tableId,
    required super.guestName,
    required super.phone,
    required super.time,
    required super.guestsCount,
    required super.status,
    super.specialRequests,
    super.table,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      tableId: json['table_id'],
      guestName: json['guest_name'] ?? '',
      phone: json['guest_phone'] ?? '',
      time: DateTime.parse(json['reservation_time']),
      guestsCount: json['guests_count'] ?? 0,
      status: json['status'] ?? 'pending',
      specialRequests: json['special_requests'],
      table: json['table'] != null ? TableModel.fromJson(json['table']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'table_id': tableId,
      'guest_name': guestName,
      'guest_phone': phone,
      'reservation_time': time,
      'guests_count': guestsCount,
      'special_requests': specialRequests,
    };
  }
}