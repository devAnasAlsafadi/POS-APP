import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../entities/reservation_entity.dart';
import '../repositories/reservations_repository.dart';

class GetUpcomingReservationsUseCase {
  final ReservationsRepository repository;
  GetUpcomingReservationsUseCase(this.repository);

  Future<Either<Failure, SuccessResponse<List<ReservationEntity>>>> call() async {
    return await repository.getUpcomingReservations();
  }
}