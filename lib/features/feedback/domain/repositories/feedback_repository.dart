import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/features/feedback/domain/entities/feedback_entity.dart';
import '../../../../core/api/api_response.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../../data/models/feedback_model.dart';

abstract class FeedbackRepository {
  Future<Either<Failure, SuccessResponse<FeedbackEntity>>> submitFeedback(FeedbackEntity feedback);
}
