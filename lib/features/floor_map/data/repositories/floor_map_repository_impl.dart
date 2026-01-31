import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/table_entity.dart';
import '../../domain/repositories/floor_map_repository.dart';
import '../data_source/floor_map_remote_data_source.dart';

class FloorMapRepositoryImpl implements FloorMapRepository {
  final FloorMapRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FloorMapRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<TableEntity>>> getTables() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTables = await remoteDataSource.getTables();
        return Right(remoteTables);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}