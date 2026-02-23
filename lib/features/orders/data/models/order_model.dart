import 'package:pos_wiz_tech/features/floor_map/data/models/table_model.dart';
import 'package:pos_wiz_tech/features/products/data/models/product_model.dart';
import 'package:pos_wiz_tech/features/orders/domain/entities/order_entity.dart';
import '../../domain/entities/order_product_entity.dart';
import 'customer_model.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.toGo,
    required super.invoiceNum,
    required super.totalAmount,
    required super.subtotalAmount,
    super.discountAmount,
    super.paidAmount,
    required super.status,
    required super.stage,
    required super.readyStatus,
    required super.payStatus,
    required super.deliverStatus,
    required super.editStatus,
    super.method,
    super.description,
    super.bellId,
    super.addressId,
    super.confirmedAt,
    super.kitchenStartedAt,
    super.kitchenCompletedAt,
    super.servedAt,
    super.billRequestedAt,
    super.completedAt,
    required super.createdAt,
    required super.updatedAt,
    super.table,
    super.customer,
    required super.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      toGo: json['to_go'] ?? 0,
      invoiceNum: json['invoice_num'] ?? '',
      totalAmount: double.tryParse(json['total_amount']?.toString() ?? '0') ?? 0.0,
      subtotalAmount: double.tryParse(json['subtotal_amount']?.toString() ?? '0') ?? 0.0,
      discountAmount: json['discount_amount'] != null ? double.tryParse(json['discount_amount'].toString()) : null,
      paidAmount: json['paid_amount'] != null ? double.tryParse(json['paid_amount'].toString()) : null,
      // Mapping 'status' from JSON if available, otherwise utilizing other status fields if needed.
      // NOTE: The JSON shows 'ready_status', 'pay_status', 'deliver_status', 'stage', but no top-level 'status' string field visible in the snippet provided except inside 'dining_table'.
      // However, usually there is a general status. If not, we might map it empty or from one of the sub-statuses.
      // The snippet assumes 'stage' might be the general status indicator or we use 'ready_status'.
      // Inspecting JSON again: "stage": -1.
      // We will keep 'status' and map it to ready_status if explicit status is missing, or empty string.
      status: json['status']?.toString() ?? 'pending', 
      stage: json['stage'] ?? 0,
      readyStatus: json['ready_status'] ?? 'pending',
      payStatus: json['pay_status'] ?? 'unpaid',
      deliverStatus: json['deliver_status'] ?? 'pending',
      editStatus: json['edit_status'] ?? 'notedited',
      method: json['method'],
      description: json['description'],
      bellId: json['bell_id'],
      addressId: json['address_id'],
      confirmedAt: json['confirmed_at'],
      kitchenStartedAt: json['kitchen_started_at'],
      kitchenCompletedAt: json['kitchen_completed_at'],
      servedAt: json['served_at'],
      billRequestedAt: json['bill_requested_at'],
      completedAt: json['completed_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',


      table: json['dining_table'] != null ? TableModel.fromJson(json['dining_table']) : null,
      customer: json['customer'] != null ? CustomerModel.fromJson(json['customer']) : null,
      products: json['products'] != null
          ? (json['products'] as List).map((e) => OrderProductModel.fromJson(e)).toList()
          : [],
    );
  }


  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      toGo: toGo,
      invoiceNum: invoiceNum,
      totalAmount: totalAmount,
      subtotalAmount: subtotalAmount,
      discountAmount: discountAmount,
      paidAmount: paidAmount,
      status: status,
      stage: stage,
      readyStatus: readyStatus,
      payStatus: payStatus,
      deliverStatus: deliverStatus,
      editStatus: editStatus,
      method: method,
      description: description,
      bellId: bellId,
      addressId: addressId,
      confirmedAt: confirmedAt,
      kitchenStartedAt: kitchenStartedAt,
      kitchenCompletedAt: kitchenCompletedAt,
      servedAt: servedAt,
      billRequestedAt: billRequestedAt,
      completedAt: completedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      table: table,
      customer: customer,
      // تحويل القائمة (List) من Model لـ Entity
      products: products.map((e) => (e as OrderProductModel).toEntity()).toList(),
    );
  }
}

class OrderProductModel extends OrderProductEntity {
  const OrderProductModel({
    required super.id,
    required super.userId,
    required super.categoryId,
    required super.photoId,
    required super.nameAr,
    required super.nameEn,
    required super.descAr,
    required super.descEn,
    required super.price,
    required super.salePrice,
    required super.isAvailable,
    required super.type,
    required super.isFeatured,
    required super.imageUrl,
    required super.category,
    required super.count,
    super.notes,
    super.isTakeaway,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    final product = ProductModel.fromJson(json);
    final pivot = json['pivot'];

    return OrderProductModel(
      id: product.id,
      userId: product.userId,
      categoryId: product.categoryId,
      photoId: product.photoId,
      nameAr: product.name,
      nameEn: product.nameEn,
      descAr: product.description,
      descEn: product.descriptionEn,
      price: product.price,
      salePrice: product.salePrice,
      isAvailable: product.status,
      type: product.type,
      isFeatured: product.featured,
      imageUrl: product.imageUrl,
      category: product.category.toEntity(),
      count: pivot != null ? (pivot['count'] as int) : 0,
      notes: pivot != null ? pivot['notes'] : null,
      isTakeaway: pivot != null ? (pivot['is_takeaway'] == 1 || pivot['is_takeaway'] == true) : false, // Assuming structure
    );
  }


  OrderProductEntity toEntity() {
    return OrderProductEntity(
      id: id,
      userId: userId,
      categoryId: categoryId,
      photoId: photoId,
      nameAr: nameAr,
      nameEn: nameEn,
      descAr: descAr,
      descEn: descEn,
      price: price,
      salePrice: salePrice,
      isAvailable: isAvailable,
      type: type,
      isFeatured: isFeatured,
      imageUrl: imageUrl,
      category: category,
      count: count,
      notes: notes,
      isTakeaway: isTakeaway,
    );
  }
}
