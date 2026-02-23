
import '../../domain/entities/category_entity.dart';

class CategoryModel {
  final int id;
  final String name;
  final String nameEn;
  final int isMain;

  CategoryModel({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.isMain
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameEn: json['name_en'] ?? '',
      isMain: json['is_main'] ?? 0,
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      nameAr: name,
      nameEn: nameEn,
      isMain: isMain,
    );
  }


}