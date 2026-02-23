
import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/domain/entities/success_response.dart';
import 'package:pos_wiz_tech/core/errors/exceptions.dart';
import 'package:pos_wiz_tech/features/reservations/data/datasources/reservations_remote_data_source.dart';
import 'package:pos_wiz_tech/features/reservations/data/models/reservation_model.dart';
import 'package:pos_wiz_tech/features/reservations/domain/entities/reservation_entity.dart';
import 'package:pos_wiz_tech/features/reservations/domain/repositories/reservations_repository.dart';
import '../../../../core/errors/errors.dart';

class ReservationsRepositoryImpl implements ReservationsRepository {
  final ReservationsRemoteDataSource remoteDataSource;

  ReservationsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SuccessResponse<List<ReservationEntity>>>> getAllReservations() async {
    try {
      final response = await remoteDataSource.getAllReservations();
      return Right(SuccessResponse<List<ReservationEntity>>(
        data: response.data,
        message: response.message ?? "Fetched Reservations successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessResponse<List<ReservationEntity>>>> getTodayReservations() async {
    try {
      final response = await remoteDataSource.getTodayReservations();
      return Right(SuccessResponse<List<ReservationEntity>>(
        data: response.data,
        message: response.message ?? "Fetched Today Reservations successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessResponse<ReservationEntity>>> createReservation(Map<String, dynamic> body) async {
    try {
      final response = await remoteDataSource.createReservation(body);
      return Right(SuccessResponse<ReservationEntity>(
        data: response.data,
        message: response.message ?? "Create Reservation successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessResponse<ReservationEntity>>> checkInReservation(int id) async {
    try {
      final response  = await remoteDataSource.checkInReservation(id);
      return Right(SuccessResponse<ReservationEntity>(
        data: response.data,
        message: response.message ?? "Check In Reservations successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessResponse<ReservationEntity>>> cancelReservation(int id) async {
    try {
     final response =  await remoteDataSource.cancelReservation(id);
     return Right(SuccessResponse<ReservationEntity>(
       data: response.data,
       message: response.message ?? "Cancel Reservation successfully",
       status: response.status ?? true,
     ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure,SuccessResponse<List<ReservationEntity>>>> getUpcomingReservations()async {
    try {
      final response = await remoteDataSource.getUpcomingReservations();
      return Right(SuccessResponse<List<ReservationEntity>>(
        data: response.data,
        message: response.message ?? "Fetched UpComing Reservations successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessResponse<ReservationEntity>>> noShowReservation(int id) async {
    try {
      final response = await remoteDataSource.noShowReservation(id);
      return Right(SuccessResponse<ReservationEntity>(
        data: response.data,
        message: response.message ?? "Fetched UpComing Reservations successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
