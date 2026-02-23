import 'package:pos_wiz_tech/core/domain/entities/success_response.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/api_response.dart';
import '../../../../core/api/end_points.dart';
import '../models/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<SuccessResponse<List<OrderModel>>> getAllOrders();
  Future<SuccessResponse<OrderModel>> getOrderById(int id);
  Future<SuccessResponse<OrderModel>> createOrder(Map<String, dynamic> orderData);
  Future<SuccessResponse<List<OrderModel>>> getActiveOrders();
  Future<SuccessResponse<OrderModel>> updateOrderStatus(int id, int stage);
  Future<SuccessResponse<OrderModel>> markOrderAsServed(int id);
  Future<SuccessResponse<OrderModel>> requestBill(int id);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiConsumer api;

  OrdersRemoteDataSourceImpl({required this.api});

  @override
  Future<SuccessResponse<List<OrderModel>>> getAllOrders() async {
    final response = await api.get(EndPoints.allOrders);

    final apiResponse = ApiResponse<List<OrderModel>>.fromJson(
      response,
      (json) => (json as List).map((item) => OrderModel.fromJson(item)).toList(),
    );
    return SuccessResponse.fromApiResponse(apiResponse);

  }

  @override
  Future<SuccessResponse<OrderModel>> getOrderById(int id) async {
    final response = await api.get('${EndPoints.allOrders}/$id');

    final apiResponse = ApiResponse<OrderModel>.fromJson(
      response,
      (json) => OrderModel.fromJson(json),
    );

    return SuccessResponse.fromApiResponse(apiResponse);
  }

  @override
  Future<SuccessResponse<OrderModel>> createOrder(Map<String, dynamic> orderData) async {
    final response = await api.post(EndPoints.allOrders, body: orderData);

    final apiResponse = ApiResponse<OrderModel>.fromJson(
      response,
      (json) => OrderModel.fromJson(json),
    );

    return SuccessResponse.fromApiResponse(apiResponse);
  }

  @override
  Future<SuccessResponse<List<OrderModel>>> getActiveOrders() async {
    final response = await api.get(EndPoints.activeOrders);

    final apiResponse = ApiResponse<List<OrderModel>>.fromJson(
      response,
      (json) => (json as List).map((item) => OrderModel.fromJson(item)).toList(),
    );

    return SuccessResponse.fromApiResponse(apiResponse);
  }

  @override
  Future<SuccessResponse<OrderModel>> updateOrderStatus(int id, int stage) async {
    final response = await api.patch(
      '${EndPoints.allOrders}/$id/status',
      body: {'stage': stage},
    );

    final apiResponse = ApiResponse<OrderModel>.fromJson(
      response,
      (json) => OrderModel.fromJson(json),
    );

    return SuccessResponse.fromApiResponse(apiResponse);
  }

  @override
  Future<SuccessResponse<OrderModel>> markOrderAsServed(int id) async {
    final response = await api.post('${EndPoints.allOrders}/$id/serve');

    final apiResponse = ApiResponse<OrderModel>.fromJson(
      response,
      (json) => OrderModel.fromJson(json),
    );

    return SuccessResponse.fromApiResponse(apiResponse);
  }

  @override
  Future<SuccessResponse<OrderModel>> requestBill(int id) async {
    final response = await api.post('${EndPoints.allOrders}/$id/request-bill');

    final apiResponse = ApiResponse<OrderModel>.fromJson(
      response,
      (json) => OrderModel.fromJson(json),
    );

    return SuccessResponse.fromApiResponse(apiResponse);
  }
}
