import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/table_entity.dart';
import '../../domain/repositories/table_repository.dart';
import '../data_source/tables_remote_data_source.dart';

class TableRepositoryImpl implements TableRepository {

  final TablesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TableRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });


  @override
  Future<Either<Failure, List<TableEntity>>> getAllTables() async {
    try {
      final remoteTables = await remoteDataSource.getAllTables();
      return Right(remoteTables);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected Error: ${e.toString()}"));
    }
  }

}