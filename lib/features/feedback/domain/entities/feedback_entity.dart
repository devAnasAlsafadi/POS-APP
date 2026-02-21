import 'package:equatable/equatable.dart';

class FeedbackEntity extends Equatable {
  final int orderId;
  final int overallRating;
  final int foodQualityRating;
  final int serviceRating;
  final int speedRating;
  final String? comment;
  final List<String> feedbackTags;

  const FeedbackEntity({
    required this.orderId,
    required this.overallRating,
    required this.foodQualityRating,
    required this.serviceRating,
    required this.speedRating,
    this.comment,
    required this.feedbackTags,
  });

  @override
  List<Object?> get props => [
    orderId, overallRating, foodQualityRating,
    serviceRating, speedRating, comment, feedbackTags,
  ];
}