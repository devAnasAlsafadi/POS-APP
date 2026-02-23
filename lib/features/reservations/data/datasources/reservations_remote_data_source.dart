
import 'package:pos_wiz_tech/core/api/api_consumer.dart';
import 'package:pos_wiz_tech/core/api/api_response.dart';
import 'package:pos_wiz_tech/core/domain/entities/success_response.dart';
import 'package:pos_wiz_tech/features/reservations/data/models/reservation_model.dart';
import '../../../../core/api/end_points.dart';

abstract class ReservationsRemoteDataSource {
  Future<SuccessResponse<List<ReservationModel>>> getAllReservations();
  Future<SuccessResponse<List<ReservationModel>>> getTodayReservations();
  Future<SuccessResponse<List<ReservationModel>>> getUpcomingReservations();
  Future<SuccessResponse<ReservationModel>> getSingleReservation(int id);
  Future<SuccessResponse<ReservationModel>> createReservation(Map<String, dynamic> body);
  Future<SuccessResponse<ReservationModel>> checkInReservation(int id);
  Future<SuccessResponse<ReservationModel>> cancelReservation(int id);
  Future<SuccessResponse<ReservationModel>> noShowReservation(int id);
}

class ReservationsRemoteDataSourceImpl implements ReservationsRemoteDataSource {
  final ApiConsumer apiConsumer;

  ReservationsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<SuccessResponse<List<ReservationModel>>> getAllReservations() async {
    final response = await apiConsumer.get(EndPoints.allReservations);
    final apiResponse =  ApiResponse<List<ReservationModel>>.fromJson(
      response,
          (json) => (json as List).map((item) => ReservationModel.fromJson(item)).toList(),
    );
    return SuccessResponse.fromApiResponse(apiResponse);
  }

  @override
  Future<SuccessResponse<List<ReservationModel>>> getTodayReservations() async {
    final response = await apiConsumer.get(EndPoints.todayReservations);
    final apiResponse =  ApiResponse<List<ReservationModel>>.fromJson(
      response,
          (json) => (json as List).map((item) => ReservationModel.fromJson(item)).toList(),
    );
    return SuccessResponse.fromApiResponse(apiResponse);
  }


  @override
  Future<SuccessResponse<List<ReservationModel>>> getUpcomingReservations()async {
    final response = await apiConsumer.get(EndPoints.upcomingReservations);
    final apiResponse =  ApiResponse<List<ReservationModel>>.fromJson(
      response,
          (json) => (json as List).map((item) => ReservationModel.fromJson(item)).toList(),
    );
    return SuccessResponse.fromApiResponse(apiResponse);
  }



  @override
  Future<SuccessResponse<ReservationModel>> createReservation(Map<String, dynamic> body) async {
    final response = await apiConsumer.post(EndPoints.createReservation, body: body);
    final apiResponse = ApiResponse<ReservationModel>.fromJson(
      response,
          (json) => ReservationModel.fromJson(json),
    );

    return SuccessResponse.fromApiResponse(apiResponse);
  }

  @override
  Future<SuccessResponse<ReservationModel>> checkInReservation(int id) async {
    final response = await apiConsumer.post(EndPoints.checkInReservation(id));
    final apiResponse = ApiResponse<ReservationModel>.fromJson(
      response,
          (json) => ReservationModel.fromJson(json as Map<String, dynamic>),
    );

    return SuccessResponse.fromApiResponse(apiResponse);
  }

  @override
  Future<SuccessResponse<ReservationModel>> cancelReservation(int id) async {
    final response = await apiConsumer.post(EndPoints.cancelReservation(id));
    final apiResponse = ApiResponse<ReservationModel>.fromJson(
      response,
          (json) => ReservationModel.fromJson(json as Map<String, dynamic>),
    );

    return SuccessResponse.fromApiResponse(apiResponse);
  }

  @override
  Future<SuccessResponse<ReservationModel>> getSingleReservation(int id) async {
    final response = await apiConsumer.post("${EndPoints.allReservations}/$id");
    final apiResponse = ApiResponse<ReservationModel>.fromJson(
      response,
          (json) => ReservationModel.fromJson(json as Map<String, dynamic>),
    );

    return SuccessResponse.fromApiResponse(apiResponse);
  }

  @override
  Future<SuccessResponse<ReservationModel>> noShowReservation(int id) async {
    final response = await apiConsumer.post(EndPoints.noShowReservation(id));
    final apiResponse = ApiResponse<ReservationModel>.fromJson(
      response,
          (json) => ReservationModel.fromJson(json as Map<String, dynamic>),
    );

    return SuccessResponse.fromApiResponse(apiResponse);
  }

}
