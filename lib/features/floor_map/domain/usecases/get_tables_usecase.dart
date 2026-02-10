import 'package:dartz/dartz.dart';
import '../../../../core/errors/errors.dart';
import '../entities/table_entity.dart';
import '../repositories/table_repository.dart';

class GetTablesUseCase  {
  final TableRepository repository;

  GetTablesUseCase(this.repository);

  Future<Either<Failure, List<TableEntity>>> call() async {
    return await repository.getAllTables();
  }
}