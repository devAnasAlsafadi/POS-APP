import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../../domain/entities/order_entity.dart';

abstract class OrdersRepository {
  Future<Either<Failure, SuccessResponse<List<OrderEntity>>>> getOrders();
  Future<Either<Failure, SuccessResponse<OrderEntity>>> getOrderById(int id);
  Future<Either<Failure, SuccessResponse<OrderEntity>>> createOrder(Map<String, dynamic> orderData);
  Future<Either<Failure, SuccessResponse<List<OrderEntity>>>> getActiveOrders();
  Future<Either<Failure, SuccessResponse<OrderEntity>>> updateOrderStatus(int id, int stage);
  Future<Either<Failure, SuccessResponse<OrderEntity>>> markOrderAsServed(int id);
  Future<Either<Failure, SuccessResponse<OrderEntity>>> requestBill(int id);
}
