part of 'review_bloc.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<Review> reviews;

  const ReviewLoaded({required this.reviews});

  @override
  List<Object> get props => [];
}

class ReviewFailure extends ReviewState {
  final String error;

  const ReviewFailure({required this.error});

  @override
  List<Object> get props => [];
}
