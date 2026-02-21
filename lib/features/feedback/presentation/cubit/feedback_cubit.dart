import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/feedback_entity.dart';
import '../../domain/usecases/submit_feedback_use_case.dart';
import 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final SubmitFeedbackUseCase submitFeedbackUseCase;

  FeedbackCubit({required this.submitFeedbackUseCase}) : super(FeedbackInitial());

  Future<void> submitFeedback(FeedbackEntity feedback) async {
    emit(FeedbackLoading());

    final result = await submitFeedbackUseCase(feedback);

    result.fold(
          (failure) => emit(FeedbackError(failure.message)),
          (successResponse) => emit(FeedbackSuccess(successResponse.message ?? "Success")),
    );
  }
}