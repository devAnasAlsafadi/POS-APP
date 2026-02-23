import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/api_response.dart';
import '../../../../core/api/end_points.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getAllMenuData();
}


class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiConsumer api;

  ProductsRemoteDataSourceImpl({required this.api});
  @override
  Future<List<ProductModel>> getAllMenuData() async {
    final response = await api.get(EndPoints.allProducts);

    final apiResponse = ApiResponse<List<ProductModel>>.fromJson(
      response,
          (json) => (json as List).map((item) => ProductModel.fromJson(item)).toList(),
    );

    return apiResponse.data ?? [];
  }



}