part of 'create_review_bloc.dart';

abstract class CreateReviewEvent extends Equatable {
  const CreateReviewEvent();

  @override
  List<Object> get props => [];
}

class CreateReview extends CreateReviewEvent {
  final Map<dynamic, dynamic> reviewData;
  final String serviceId;

  const CreateReview({
    required this.reviewData,
    required this.serviceId,
  });

  @override
  List<Object> get props => [];
}
