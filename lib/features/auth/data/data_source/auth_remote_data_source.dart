import 'package:pos_wiz_tech/core/api/api_response.dart';
import 'package:pos_wiz_tech/core/api/end_points.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<SuccessResponse<UserModel>> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final ApiConsumer api;
  AuthRemoteDataSourceImpl({required this.api});

  @override
  Future<SuccessResponse<UserModel>> login({required String email, required String password})async {
    final response = await api.post(EndPoints.login,body:
    {
      'email': email,
      'password': password,
    }
  );



    final apiResponse = ApiResponse<UserModel>.fromJson(
      response,
          (json) => UserModel.fromJson(json),
    );
    return SuccessResponse.fromApiResponse(apiResponse);
  }

}

