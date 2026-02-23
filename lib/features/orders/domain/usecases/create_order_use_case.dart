import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class CreateOrderUseCase {
  final OrdersRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failure, SuccessResponse<OrderEntity>>> call(Map<String, dynamic> orderData) async {
    return await repository.createOrder(orderData);
  }
}
