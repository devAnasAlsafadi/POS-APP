import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/api/api_response.dart';
import 'package:pos_wiz_tech/core/errors/exceptions.dart';
import '../../../../core/domain/entities/success_response.dart';
import '../../../../core/errors/errors.dart';
import '../../domain/entities/feedback_entity.dart';
import '../../domain/repositories/feedback_repository.dart';
import '../datasources/feedback_remote_data_source.dart';
import '../models/feedback_model.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackRemoteDataSource remoteDataSource;

  FeedbackRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SuccessResponse<FeedbackEntity>>> submitFeedback(FeedbackEntity feedback) async {
    try {
      final model = FeedbackModel.fromEntity(feedback);
      final response = await remoteDataSource.submitFeedback(model);
      return Right(SuccessResponse<FeedbackEntity>(
        data: response.data!.toEntity(),
        message: response.message ?? "Feedback successfully",
        status: response.status ?? true,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
