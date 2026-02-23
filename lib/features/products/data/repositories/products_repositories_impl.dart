import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/features/products/data/data_source/products_remote_data_source.dart';
import 'package:pos_wiz_tech/features/products/domain/repositories/products_repositories.dart';
import '../../../../core/errors/errors.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/menu_data_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../models/product_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MenuDataEntity>> getMenuData() async {
    try {
      final List<ProductModel> productModels = await remoteDataSource.getAllMenuData();

      final productEntities = productModels.map((m) => m.toEntity()).toList();


      final categoryEntities = productEntities
          .map((p) => p.category)
          .fold<Map<int, CategoryEntity>>({}, (map, cat) {
        map[cat.id] = cat;
        return map;
      })
          .values
          .toList();

      return Right(MenuDataEntity(
        products: productEntities,
        categories: categoryEntities,
      ));
    }  on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}