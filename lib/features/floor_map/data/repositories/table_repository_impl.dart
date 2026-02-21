import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/developer.dart';

import '../../../../core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/table_entity.dart';
import '../../domain/repositories/table_repository.dart';
import '../data_source/tables_remote_data_source.dart';

class TableRepositoryImpl implements TableRepository {

  final TablesRemoteDataSource remoteDataSource;

  TableRepositoryImpl({
    required this.remoteDataSource,
  });


  @override
  Future<Either<Failure, SuccessResponse<List<TableEntity>>>> getAllTables() async {
    try {
      final response = await remoteDataSource.getAllTables();
      return Right(SuccessResponse<List<TableEntity>>(
        data: response.data,
        message: response.message ?? "Fetched tables successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      AppLogger.info("e.message is : ${e.message}");
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessResponse<TableEntity>>> updateTableStatus(int id , String status) async{
    try {
      final response = await remoteDataSource.updateTableStatus(id,status);
      return Right(SuccessResponse<TableEntity>(
        data: response.data!.toEntity(),
        message: response.message ?? "Update Table successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

}