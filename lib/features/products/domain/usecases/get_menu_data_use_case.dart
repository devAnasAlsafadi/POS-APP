// features/orders/domain/use_cases/get_menu_data_use_case.dart

import 'package:dartz/dartz.dart';
import '../../../../core/errors/errors.dart';
import '../entities/menu_data_entity.dart';
import '../repositories/products_repositories.dart';

class GetMenuDataUseCase {
  final ProductsRepository repository;

  GetMenuDataUseCase(this.repository);

  Future<Either<Failure, MenuDataEntity>> call() async {
    return await repository.getMenuData();
  }
}