part of 'get_reviews_bloc.dart';

abstract class GetReviewsEvent extends Equatable {
  const GetReviewsEvent();

  @override
  List<Object> get props => [];
}

class GetReviews extends GetReviewsEvent {
  final String serviceId;

  const GetReviews({required this.serviceId});

  @override
  List<Object> get props => [];
}
