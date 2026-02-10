import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/api/api_response.dart';
import 'package:pos_wiz_tech/core/errors/errors.dart';
import 'package:pos_wiz_tech/features/auth/data/models/user_model.dart';
import 'package:pos_wiz_tech/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure,UserEntity>> login(String email, String password);
  Future<ApiResponse> logout();
}
