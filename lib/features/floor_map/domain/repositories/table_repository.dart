import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/domain/entities/success_response.dart';

import '../../../../core/errors/errors.dart';
import '../entities/table_entity.dart';

abstract class TableRepository {
  Future<Either<Failure, SuccessResponse<List<TableEntity>>>> getAllTables();
  Future<Either<Failure, SuccessResponse<TableEntity>>> updateTableStatus(int tableId, String status);
}