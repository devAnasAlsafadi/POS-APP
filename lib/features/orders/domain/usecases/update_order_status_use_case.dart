import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class UpdateOrderStatusUseCase {
  final OrdersRepository repository;

  UpdateOrderStatusUseCase(this.repository);

  Future<Either<Failure,  SuccessResponse<OrderEntity>>> call(int id, int stage) async {
    return await repository.updateOrderStatus(id, stage);
  }
}
