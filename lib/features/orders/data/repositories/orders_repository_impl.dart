import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/features/orders/domain/repositories/orders_repository.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/order_entity.dart';
import '../data_source/orders_remote_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource remoteDataSource;

  OrdersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SuccessResponse<List<OrderEntity>>>> getOrders() async {
    try {
      final response = await remoteDataSource.getAllOrders();
      return Right(SuccessResponse<List<OrderEntity>>(
        data: response.data,
        message: response.message ?? "Fetched orders successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessResponse<OrderEntity>>> getOrderById(int id) async {
    try {
      final response = await remoteDataSource.getOrderById(id);
      return Right(SuccessResponse<OrderEntity>(
        data: response.data,
        message: response.message ?? "Fetched order successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessResponse<OrderEntity>>> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await remoteDataSource.createOrder(orderData);
      return Right(SuccessResponse<OrderEntity>(
        data: response.data!.toEntity(),
        message: response.message ?? "Order created successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure,SuccessResponse<List<OrderEntity>>>> getActiveOrders() async {
    try {
      final response = await remoteDataSource.getActiveOrders();
      return Right(SuccessResponse<List<OrderEntity>>(
        data: response.data,
        message: response.message ?? "Fetched active orders successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessResponse<OrderEntity>>> updateOrderStatus(int id, int stage) async {
    try {
      final response = await remoteDataSource.updateOrderStatus(id, stage);
      return Right(SuccessResponse<OrderEntity>(
        data: response.data!.toEntity(),
        message: response.message ?? "Order status updated successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessResponse<OrderEntity>>> markOrderAsServed(int id) async {
    try {
      final response = await remoteDataSource.markOrderAsServed(id);
      return Right(SuccessResponse<OrderEntity>(
        data: response.data!.toEntity(),
        message: response.message ?? "Order marked as served successfully",
        status: response.status ?? true,
      ));      } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessResponse<OrderEntity>>> requestBill(int id) async {
    try {
      final response = await remoteDataSource.requestBill(id);
      return Right(SuccessResponse<OrderEntity>(
        data: response.data!.toEntity(),
        message: response.message ?? "Bill requested successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
