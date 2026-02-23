import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class GetActiveOrdersUseCase {
  final OrdersRepository repository;

  GetActiveOrdersUseCase(this.repository);

  Future<Either<Failure, SuccessResponse<List<OrderEntity>>>> call() async {
    return await repository.getActiveOrders();
  }
}
