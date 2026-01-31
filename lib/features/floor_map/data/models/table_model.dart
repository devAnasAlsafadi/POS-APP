import '../../../../core/enum/table_status.dart';
import '../../domain/entities/table_entity.dart';

class TableModel extends TableEntity {
   TableModel({
    required super.id,
    required super.tableNumber,
    required super.floorId,
    required super.chairCount,
    required super.status,
    super.totalAmount,
    super.orders,
    super.reservationTime,
    super.isReserved,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      tableNumber: json['table_number'],
      floorId: json['floor_id'],
      chairCount: json['chair_count'],
      status: TableStatus.values.byName(json['status']),
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      reservationTime: json['reservation_time'],
      isReserved: json['is_reserved'] ?? false,
      orders: (json['orders'] as List?)
          ?.map((o) => TableOrderModel.fromJson(o))
          .toList(),
    );
  }
}

class TableOrderModel extends TableOrderEntity {
  const TableOrderModel({required super.orderId, required super.orderTime, required super.items});

  factory TableOrderModel.fromJson(Map<String, dynamic> json) {
    return TableOrderModel(
      orderId: json['order_id'],
      orderTime: DateTime.parse(json['order_time']),
      items: List<String>.from(json['items'] ?? []),
    );
  }
}