import 'package:pos_wiz_tech/core/api/api_consumer.dart';
import '../../../../core/api/api_response.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../models/feedback_model.dart';

abstract class FeedbackRemoteDataSource {
  Future<SuccessResponse<FeedbackModel>> submitFeedback(FeedbackModel feedback);
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource {
  final ApiConsumer apiConsumer;

  FeedbackRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<SuccessResponse<FeedbackModel>> submitFeedback(FeedbackModel feedback) async {
    final response = await apiConsumer.post(EndPoints.feedback, body: feedback.toJson());
    final apiResponse = ApiResponse<FeedbackModel>.fromJson(
      response,
          (json) => FeedbackModel.fromJson(json),
    );

    return SuccessResponse.fromApiResponse(apiResponse);
  }
}
