part of 'get_reviews_bloc.dart';

abstract class GetReviewsState extends Equatable {
  const GetReviewsState();

  @override
  List<Object> get props => [];
}

class GetReviewsInitial extends GetReviewsState {}

class GetReviewsLoading extends GetReviewsState {}

class GetReviewsSuccess extends GetReviewsState {
  final List<Review> reviews;

  const GetReviewsSuccess({required this.reviews});

  @override
  List<Object> get props => [];
}

class GetReviewsFailure extends GetReviewsState {
  final String error;

  const GetReviewsFailure({required this.error});

  @override
  List<Object> get props => [];
}
