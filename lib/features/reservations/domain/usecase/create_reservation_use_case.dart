import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../entities/reservation_entity.dart';
import '../repositories/reservations_repository.dart';

class CreateReservationUseCase {
  final ReservationsRepository repository;
  CreateReservationUseCase(this.repository);

  Future<Either<Failure, SuccessResponse<ReservationEntity>>> call(Map<String, dynamic> body) async {
    return await repository.createReservation(body);
  }
}