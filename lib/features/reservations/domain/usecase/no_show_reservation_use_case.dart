import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../entities/reservation_entity.dart';
import '../repositories/reservations_repository.dart';

class NoShowReservationUseCase {
  final ReservationsRepository repository;
  NoShowReservationUseCase(this.repository);

  Future<Either<Failure, SuccessResponse<ReservationEntity>>> call(int id) async {
    return await repository.noShowReservation(id);
  }
}