import 'package:equatable/equatable.dart';
import 'package:pos_wiz_tech/core/enum/table_status.dart';

class TableEntity extends Equatable {
  final String id;
  final String tableNumber;
  final String floorId;
  final int chairCount;
  final TableStatus status;
  final double? totalAmount;
  final List<TableOrderEntity>? orders;
  final DateTime? reservationTime;
  final bool isReserved;


  TableEntity({
    required this.id,
    required this.tableNumber,
    required this.floorId,
    required this.chairCount,
    required this.status,
    this.totalAmount,
    this.orders,
    this.reservationTime,
    this.isReserved = false,
  });

  @override
  List<Object?> get props => [id, tableNumber, status, totalAmount, isReserved,orders,floorId , chairCount,reservationTime];

}

class TableOrderEntity extends Equatable {
  final String orderId;
  final DateTime orderTime;
  final List<String> items;

  const TableOrderEntity({
    required this.orderId,
    required this.orderTime,
    required this.items,
  });

  @override
  List<Object?> get props => [orderId, orderTime,items];
}