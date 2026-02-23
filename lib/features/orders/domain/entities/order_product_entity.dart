import 'package:pos_wiz_tech/features/products/domain/entities/product_entity.dart';

class OrderProductEntity extends ProductEntity {
  final int count;
  final String? notes;
  final bool isTakeaway;

  const OrderProductEntity({
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
    required this.count,
    this.notes,
    this.isTakeaway = false,
  });

  factory OrderProductEntity.fromProduct(ProductEntity product) {
    return OrderProductEntity(
      id: product.id,
      userId: product.userId,
      categoryId: product.categoryId,
      photoId: product.photoId,
      nameAr: product.nameAr,
      nameEn: product.nameEn,
      descAr: product.descAr,
      descEn: product.descEn,
      price: product.price,
      salePrice: product.salePrice,
      isAvailable: product.isAvailable,
      type: product.type,
      isFeatured: product.isFeatured,
      imageUrl: product.imageUrl,
      category: product.category,
      count: 1,
      notes: null,
      isTakeaway: false,
    );
  }

  OrderProductEntity copyWith({
    int? count,
    String? notes,
    bool? isTakeaway,
  }) {
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
      count: count ?? this.count,
      notes: notes ?? this.notes,
      isTakeaway: isTakeaway ?? this.isTakeaway,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        count,
        notes,
        isTakeaway,
      ];
}
