import 'package:pos_wiz_tech/core/api/api_response.dart';
import 'package:pos_wiz_tech/core/api/end_points.dart';

import '../../../../core/api/api_consumer.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse<UserModel>> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final ApiConsumer api;
  AuthRemoteDataSourceImpl({required this.api});

  @override
  Future<ApiResponse<UserModel>> login({required String email, required String password})async {
    final response = await api.post(EndPoints.login,body:
    {
      'email': email,
      'password': password,
    }
    );

    return ApiResponse<UserModel>.fromJson(response,(json) => UserModel.fromJson(json),);
  }

}

