import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../entities/table_entity.dart';
import '../repositories/floor_map_repository.dart';

class GetTablesUseCase {
  final FloorMapRepository repository;
  GetTablesUseCase({required this.repository});
  Future<Either<Failure, List<TableEntity>>> call() {
    return repository.getTables();
  }
}