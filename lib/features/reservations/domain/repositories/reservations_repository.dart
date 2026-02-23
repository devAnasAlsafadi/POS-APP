
import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/features/reservations/domain/entities/reservation_entity.dart';

import '../../../../core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../../data/models/reservation_model.dart';

abstract class ReservationsRepository {
  Future<Either<Failure, SuccessResponse<List<ReservationEntity>>>> getAllReservations();
  Future<Either<Failure, SuccessResponse<List<ReservationEntity>>>> getTodayReservations();
  Future<Either<Failure,SuccessResponse<List<ReservationEntity>>>> getUpcomingReservations();
  Future<Either<Failure, SuccessResponse<ReservationEntity>>> createReservation(Map<String, dynamic> body);
  Future<Either<Failure, SuccessResponse<ReservationEntity>>> checkInReservation(int id);
  Future<Either<Failure, SuccessResponse<ReservationEntity>>> cancelReservation(int id);
  Future<Either<Failure, SuccessResponse<ReservationEntity>>> noShowReservation(int id);
}
