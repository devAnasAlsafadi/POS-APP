import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../../domain/entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class GetOrdersUseCase {
  final OrdersRepository repository;

  GetOrdersUseCase(this.repository);

  Future<Either<Failure,  SuccessResponse<List<OrderEntity>>>> call() async {
    return await repository.getOrders();
  }
}
