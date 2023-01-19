part of 'create_review_bloc.dart';

abstract class CreateReviewState extends Equatable {
  const CreateReviewState();

  @override
  List<Object> get props => [];
}

class CreateReviewInitial extends CreateReviewState {}

class CreateReviewLoading extends CreateReviewState {}

class CreateReviewSuccess extends CreateReviewState {}

class CreateReviewFailure extends CreateReviewState {
  final String error;

  const CreateReviewFailure({required this.error});

  @override
  List<Object> get props => [];
}
