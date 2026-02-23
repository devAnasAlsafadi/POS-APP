import 'package:equatable/equatable.dart';

import '../../../floor_map/domain/entities/table_entity.dart';

class ReservationEntity extends Equatable {
  final int id;
  final int tableId;
  final String guestName;
  final String phone;
  final DateTime time;
  final int guestsCount;
  final String status; // 'confirmed', 'checked_in', 'cancelled', 'pending'
  final String? specialRequests;
  final TableEntity? table;

  const ReservationEntity({
    required this.id,
    required this.tableId,
    required this.guestName,
    required this.phone,
    required this.time,
    required this.guestsCount,
    required this.status,
    this.specialRequests,
    this.table,
  });

  @override
  List<Object?> get props => [
    id, tableId, guestName, phone, time, guestsCount, status, specialRequests, table
  ];
}