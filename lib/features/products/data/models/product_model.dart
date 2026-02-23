import '../../domain/entities/product_entity.dart';
import 'category_model.dart';

class ProductModel {
  final int id;
  final int userId;
  final int categoryId;
  final int photoId;
  final String name;
  final String nameEn;
  final String description;
  final String descriptionEn;
  final double price;
  final double salePrice;
  final int status;
  final int type;
  final int featured;
  final String imageUrl;
  final CategoryModel category;

  ProductModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.photoId,
    required this.name,
    required this.nameEn,
    required this.description,
    required this.descriptionEn,
    required this.price,
    required this.salePrice,
    required this.status,
    required this.type,
    required this.featured,
    required this.imageUrl,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Extract photo file path and construct full URL
    String photoFile = '';
    if (json['photo'] != null && json['photo']['file'] != null) {
      photoFile = json['photo']['file'];
      // If it's a relative path, prepend the base domain
      if (photoFile.startsWith('/')) {
        photoFile = 'https://pos.wiz-tech.co$photoFile';
      }
    }
    
    return ProductModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      photoId: json['photo_id'] ?? 0,
      name: json['name'] ?? '',
      nameEn: json['name_en'] ?? '',
      description: json['description'] ?? '',
      descriptionEn: json['description_en'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      salePrice: (json['sale_price'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 0,
      type: json['type'] ?? 0,
      featured: json['featured'] ?? 0,
      imageUrl: photoFile,
      category: json['category'] != null ? CategoryModel.fromJson(json['category']) :  CategoryModel(id: 0, name: '', nameEn: '', isMain: 0),
    );
  }


  // داخل كلاس ProductModel
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      userId: userId,
      categoryId: categoryId,
      photoId: photoId,
      nameAr: name,
      nameEn: nameEn,
      descAr: description,
      descEn: descriptionEn,
      price: price,
      salePrice: salePrice,
      isAvailable: status,
      type: type,
      isFeatured: featured,
      imageUrl: imageUrl,
      category: category.toEntity(),
    );
  }


}