import 'package:equatable/equatable.dart';
import 'category_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final int userId;
  final int categoryId;
  final int photoId;
  final String nameAr;
  final String nameEn;
  final String descAr;
  final String descEn;
  final double price;
  final double salePrice;
  final int isAvailable;
  final int type;
  final int isFeatured;
  final String imageUrl;
  final CategoryEntity category;

  const ProductEntity({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.photoId,
    required this.nameAr,
    required this.nameEn,
    required this.descAr,
    required this.descEn,
    required this.price,
    required this.salePrice,
    required this.isAvailable,
    required this.type,
    required this.isFeatured,
    required this.imageUrl,
    required this.category,
  });

  double get finalPrice => salePrice > 0 ? salePrice : price;

  @override
  List<Object?> get props => [
    id,
    userId,
    categoryId,
    nameAr,
    nameEn,
    price,
    salePrice,
    isAvailable,
    type,
    isFeatured
  ];
}