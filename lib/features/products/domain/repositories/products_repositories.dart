import 'package:dartz/dartz.dart';
import '../../../../core/errors/errors.dart';
import '../entities/menu_data_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, MenuDataEntity>> getMenuData();
}