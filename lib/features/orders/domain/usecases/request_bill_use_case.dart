import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class RequestBillUseCase {
  final OrdersRepository repository;

  RequestBillUseCase(this.repository);

  Future<Either<Failure,  SuccessResponse<OrderEntity>>> call(int id) async {
    return await repository.requestBill(id);
  }
}
