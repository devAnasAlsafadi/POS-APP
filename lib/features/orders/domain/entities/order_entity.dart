import 'package:equatable/equatable.dart';
import 'package:pos_wiz_tech/features/floor_map/domain/entities/table_entity.dart';
import '../../../../features/products/domain/entities/product_entity.dart';
import 'customer_entity.dart';
import 'order_product_entity.dart';

class OrderEntity extends Equatable {
  final int id;
  final int toGo;
  final String invoiceNum;
  final double totalAmount;
  final double subtotalAmount;
  final double? discountAmount;
  final double? paidAmount;
  final String status;
  final int stage;
  final String readyStatus;
  final String payStatus;
  final String deliverStatus;
  final String editStatus;
  final String? method;
  final String? description;
  final int? bellId;
  final int? addressId;
  final String? confirmedAt;
  final String? kitchenStartedAt;
  final String? kitchenCompletedAt;
  final String? servedAt;
  final String? billRequestedAt;
  final String? completedAt;
  final String createdAt;
  final String updatedAt;
  final TableEntity? table;
  final CustomerEntity? customer;
  final List<OrderProductEntity> products;

  const OrderEntity({
    required this.id,
    required this.toGo,
    required this.invoiceNum,
    required this.totalAmount,
    required this.subtotalAmount,
    this.discountAmount,
    this.paidAmount,
    required this.status,
    required this.stage,
    required this.readyStatus,
    required this.payStatus,
    required this.deliverStatus,
    required this.editStatus,
    this.method,
    this.description,
    this.bellId,
    this.addressId,
    this.confirmedAt,
    this.kitchenStartedAt,
    this.kitchenCompletedAt,
    this.servedAt,
    this.billRequestedAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    this.table,
    this.customer,
    required this.products,
  });

  @override
  List<Object?> get props => [
        id,
        invoiceNum,
        totalAmount,
        status,
        readyStatus,
        payStatus,
        deliverStatus,
        createdAt,
        updatedAt
      ];
}
