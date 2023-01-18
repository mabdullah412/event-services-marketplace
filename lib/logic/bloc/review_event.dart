part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class GetReviews extends ReviewEvent {
  final String serviceId;

  const GetReviews({required this.serviceId});

  @override
  List<Object> get props => [];
}
