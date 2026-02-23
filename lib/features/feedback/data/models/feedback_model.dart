import '../../domain/entities/feedback_entity.dart';

class FeedbackModel extends FeedbackEntity {
  const FeedbackModel({
    required super.orderId,
    required super.overallRating,
    required super.foodQualityRating,
    required super.serviceRating,
    required super.speedRating,
    super.comment,
    required super.feedbackTags,
  });

  factory FeedbackModel.fromEntity(FeedbackEntity entity) {
    return FeedbackModel(
      orderId: entity.orderId,
      overallRating: entity.overallRating,
      foodQualityRating: entity.foodQualityRating,
      serviceRating: entity.serviceRating,
      speedRating: entity.speedRating,
      comment: entity.comment,
      feedbackTags: entity.feedbackTags,
    );
  }

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      orderId: json['order_id'] as int,
      overallRating: (json['overall_rating'] as num).toInt(),
      foodQualityRating: (json['food_quality_rating'] as num).toInt(),
      serviceRating: (json['service_rating'] as num).toInt(),
      speedRating: (json['speed_rating'] as num).toInt(),
      comment: json['comment'] as String?,
      feedbackTags: json['feedback_tags'] != null
          ? List<String>.from(json['feedback_tags'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'overall_rating': overallRating,
      'food_quality_rating': foodQualityRating,
      'service_rating': serviceRating,
      'speed_rating': speedRating,
      'comment': comment,
      'feedback_tags': feedbackTags,
    };
  }

  FeedbackEntity toEntity() => FeedbackEntity(
    orderId: orderId,
    overallRating: overallRating,
    foodQualityRating: foodQualityRating,
    serviceRating: serviceRating,
    speedRating: speedRating,
    comment: comment,
    feedbackTags: feedbackTags,
  );
}