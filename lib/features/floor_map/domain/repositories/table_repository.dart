import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../entities/table_entity.dart';

abstract class TableRepository {
  Future<Either<Failure, List<TableEntity>>> getAllTables();
}