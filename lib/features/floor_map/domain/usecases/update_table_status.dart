import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../entities/table_entity.dart';
import '../repositories/table_repository.dart';

class UpdateTableStatusUseCase  {
  final TableRepository repository;

  UpdateTableStatusUseCase(this.repository);

  Future<Either<Failure, SuccessResponse<TableEntity>>> call(int tableId , String status) async {
    return await repository.updateTableStatus(tableId, status);
  }
}