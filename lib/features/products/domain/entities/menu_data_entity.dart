
import 'package:pos_wiz_tech/features/products/domain/entities/product_entity.dart';

import 'category_entity.dart';

class MenuDataEntity {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;

  MenuDataEntity({required this.products, required this.categories});
}