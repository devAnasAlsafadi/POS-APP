import 'package:dartz/dartz.dart';
import '../../../../core/errors/errors.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../entities/feedback_entity.dart';
import '../repositories/feedback_repository.dart';

class SubmitFeedbackUseCase {
  final FeedbackRepository repository;

  SubmitFeedbackUseCase(this.repository);

  Future<Either<Failure, SuccessResponse<FeedbackEntity>>> call(FeedbackEntity feedback) async {
    return await repository.submitFeedback(feedback);
  }
}