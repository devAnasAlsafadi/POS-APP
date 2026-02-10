import 'package:pos_wiz_tech/core/api/api_response.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/table_model.dart';

abstract class TablesRemoteDataSource {
  Future<List<TableModel>> getAllTables();
}

class TablesRemoteDataSourceImpl implements TablesRemoteDataSource {
  final ApiConsumer api;

  TablesRemoteDataSourceImpl({required this.api});

  @override
  Future<List<TableModel>> getAllTables() async {
    final response = await api.get(EndPoints.allTables);

    final apiResponse = ApiResponse<List<TableModel>>.fromJson(response,(json) => (json as List).map((item) => TableModel.fromJson(item)).toList(),);
    return apiResponse.data  ?? [];
  }
}


