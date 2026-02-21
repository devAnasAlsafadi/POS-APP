import 'package:pos_wiz_tech/core/api/api_response.dart';
import 'package:pos_wiz_tech/core/domain/entities/success_response.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/table_model.dart';

abstract class TablesRemoteDataSource {
  Future<SuccessResponse<List<TableModel>>> getAllTables();
  Future<SuccessResponse<TableModel>> updateTableStatus(int id,String tableStatus);
}

class TablesRemoteDataSourceImpl implements TablesRemoteDataSource {
  final ApiConsumer api;

  TablesRemoteDataSourceImpl({required this.api});

  @override
  Future<SuccessResponse<List<TableModel>>> getAllTables() async {
    final response = await api.get(EndPoints.allTables);

    final apiResponse = ApiResponse<List<TableModel>>.fromJson(response,(json) => (json as List).map((item) => TableModel.fromJson(item)).toList(),);
    return SuccessResponse.fromApiResponse(apiResponse);
  }

  @override
  Future<SuccessResponse<TableModel>> updateTableStatus(int id,String tableStatus ) async {
    final response = await api.patch("${EndPoints.allTables}/$id/status",body: {
      "status": tableStatus
    });
    final apiResponse = ApiResponse<TableModel>.fromJson(response,(json) => TableModel.fromJson(json));
    return SuccessResponse.fromApiResponse(apiResponse);

  }


}


