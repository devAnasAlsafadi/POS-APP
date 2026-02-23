import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../../domain/entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class GetOrderByIdUseCase {
  final OrdersRepository repository;

  GetOrderByIdUseCase(this.repository);

  Future<Either<Failure,  SuccessResponse<OrderEntity>>> call(int id) async {
    return await repository.getOrderById(id);
  }
}
