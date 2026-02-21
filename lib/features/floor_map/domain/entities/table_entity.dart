import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:pos_wiz_tech/core/developer.dart';
import 'package:pos_wiz_tech/features/auth/domain/entities/user_entity.dart';
import '../../../../core/enum/table_status.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../features/orders/domain/entities/order_entity.dart';

import '../../../reservations/domain/entities/reservation_entity.dart';
import 'location_entity.dart';

class TableEntity extends Equatable {
  final int id;
  final int order;
  final int? locationId;
  final int capacity;
  final bool isAvailable;
  final String status;
  final int? currentOrderId;
  final int? assignedWaiterId;
  final OrderEntity? currentOrder;
  final UserEntity? assignedWaiter;
  final LocationEntity? location;
  final ReservationEntity? activeReservation;

  const TableEntity({
    required this.id,
    required this.order,
    this.locationId,
    required this.capacity,
    required this.isAvailable,
    required this.status,
    this.currentOrderId,
    this.assignedWaiterId,
    this.currentOrder,
    this.assignedWaiter,
    this.location,
    this.activeReservation,
  });

  @override
  List<Object?> get props => [
    id, order, locationId, capacity, isAvailable, status,
    currentOrderId, assignedWaiterId, currentOrder, assignedWaiter,
    location, activeReservation,
  ];

  TableEntity copyWith({
    int? id,
    int? order,
    int? locationId,
    int? capacity,
    bool? isAvailable,
    String? status,
    int? currentOrderId,
    int? assignedWaiterId,
    OrderEntity? currentOrder,
    UserEntity? assignedWaiter,
    LocationEntity? location,
    ReservationEntity? activeReservation,
  }) {
    return TableEntity(
      id: id ?? this.id,
      order: order ?? this.order,
      locationId: locationId ?? this.locationId,
      capacity: capacity ?? this.capacity,
      isAvailable: isAvailable ?? this.isAvailable,
      status: status ?? this.status,
      currentOrderId: currentOrderId ?? this.currentOrderId,
      assignedWaiterId: assignedWaiterId ?? this.assignedWaiterId,
      currentOrder: currentOrder ?? this.currentOrder,
      assignedWaiter: assignedWaiter ?? this.assignedWaiter,
      location: location ?? this.location,
      activeReservation: activeReservation ?? this.activeReservation,
    );
  }


  bool get isReservationSoon {
    if (activeReservation == null) return false;

    final nowUtc = DateTime.now().toUtc();
    final reservationUtc = activeReservation!.time.toUtc();
    final difference = reservationUtc.difference(nowUtc).inMinutes;
    final bool isSoon = difference <= 60 && difference >= -15;
    return isSoon;
  }


  bool get hasActiveReservation => 
      activeReservation != null && activeReservation!.status == 'confirmed';

  TableStatus get currentStatus {
    if (activeReservation != null && isReservationSoon) {
      return TableStatus.reserved;
    }

    switch (status.toLowerCase()) {
      case 'occupied': return TableStatus.occupied;
      case 'dining': return TableStatus.dining;
      case 'billing': return TableStatus.billing;
      default: return TableStatus.available;
    }
  }

  Color get statusColor {
    switch (currentStatus) {
      case TableStatus.available: return AppColors.available;
      case TableStatus.occupied: return AppColors.occupied;
      case TableStatus.billing: return AppColors.billing;
      case TableStatus.reserved: return AppColors.reserved;
      default: return AppColors.dining;
    }
  }
}