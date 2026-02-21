import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/api/api_response.dart';
import 'package:pos_wiz_tech/core/errors/errors.dart';
import 'package:pos_wiz_tech/core/errors/exceptions.dart';

import 'package:pos_wiz_tech/features/auth/domain/entities/user_entity.dart';

import '../../../../core/domain/entities/success_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl({required this.remoteDataSource, required this.localDataSource});





  @override
  Future<Either<Failure, SuccessResponse<UserEntity>>> login(String email, String password)async  {
    try{
      final response = await remoteDataSource.login(email: email, password: password);
      await localDataSource.cacheToken(response.data!.token);
      await localDataSource.cacheUser(response.data!.name);
      return Right(SuccessResponse<UserEntity>(
        data: response.data!.toEntity(),
        message: response.message ?? "Logged in successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e){
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  String? getUserName() {
    return localDataSource.getUserName();
  }



  @override
  Future<ApiResponse<dynamic>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }


}