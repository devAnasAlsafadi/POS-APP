import 'package:pos_wiz_tech/features/auth/data/models/user_model.dart';
import '../../../../features/orders/data/models/order_model.dart';
import '../../domain/entities/table_entity.dart';
import 'location_model.dart';

class TableModel extends TableEntity {
  const TableModel({
    required super.id,
    required super.order,
    super.locationId,
    required super.capacity,
    required super.isAvailable,
    required super.status,
    super.currentOrderId,
    super.assignedWaiterId,
    super.currentOrder,
    super.assignedWaiter,
    super.location,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'] ?? 0,
      order: json['order'] ?? 0,
      locationId: json['location_id'],
      capacity: json['capacity'] ?? 0,
      isAvailable: json['is_available'] ?? false,
      status: json['status'] ?? 'available',
      currentOrderId: json['current_order_id'],
      assignedWaiterId: json['assigned_waiter_id'],
      currentOrder: json['current_order'] != null && json['current_order'] is Map<String, dynamic>
          ? OrderModel.fromJson(json['current_order'])
          : null,
      assignedWaiter: json['assigned_waiter'] != null && json['assigned_waiter'] is Map<String, dynamic>
          ? UserModel.fromJson(json['assigned_waiter'])
          : null,
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
    );
  }


  TableEntity toEntity() {
    return TableEntity(
      id: id,
      order: order,
      locationId: locationId,
      capacity: capacity,
      isAvailable: isAvailable,
      status: status,
      currentOrderId: currentOrderId,
      assignedWaiterId: assignedWaiterId,
      currentOrder: currentOrder,
      assignedWaiter: assignedWaiter,
      location: location,
    );
  }
}