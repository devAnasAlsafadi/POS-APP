import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/api/api_response.dart';
import 'package:pos_wiz_tech/core/errors/errors.dart';
import 'package:pos_wiz_tech/core/errors/exceptions.dart';

import 'package:pos_wiz_tech/features/auth/domain/entities/user_entity.dart';

import '../../domain/repositories/auth_repository.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl({required this.remoteDataSource, required this.localDataSource});





  @override
  Future<Either<Failure, UserEntity>> login(String email, String password)async  {
    try{
      final response = await remoteDataSource.login(email: email, password: password);
      await localDataSource.cacheToken(response.data!.token);
      return Right(response.data!.toEntity());
    } on ServerException catch (e){
      return Left(ServerFailure(message: e.message));
    }catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }



  @override
  Future<ApiResponse<dynamic>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }


}