import 'package:equatable/equatable.dart';

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
  final String? currentOrder;
  final String? assignedWaiter;
  final LocationEntity? location;

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
  });

  @override
  List<Object?> get props => [
    id,
    order,
    locationId,
    capacity,
    isAvailable,
    status,
    currentOrderId,
    assignedWaiterId,
    currentOrder,
    assignedWaiter,
    location,
  ];
}