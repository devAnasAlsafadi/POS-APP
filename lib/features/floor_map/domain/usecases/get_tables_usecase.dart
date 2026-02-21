import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../entities/table_entity.dart';
import '../repositories/table_repository.dart';

class GetTablesUseCase  {
  final TableRepository repository;

  GetTablesUseCase(this.repository);

  Future<Either<Failure, SuccessResponse<List<TableEntity>>>> call() async {
    return await repository.getAllTables();
  }
}