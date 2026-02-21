import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/api/api_response.dart';
import 'package:pos_wiz_tech/core/errors/errors.dart';
import 'package:pos_wiz_tech/features/auth/domain/entities/user_entity.dart';
import 'package:pos_wiz_tech/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/domain/entities/success_response.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure,SuccessResponse<UserEntity>>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}