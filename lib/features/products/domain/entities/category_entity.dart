import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;
  final int isMain;

  const CategoryEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.isMain,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn, isMain];
}