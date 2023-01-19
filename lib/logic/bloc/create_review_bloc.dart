import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/review_repository.dart';
import 'get_reviews_bloc.dart';

part 'create_review_event.dart';
part 'create_review_state.dart';

class CreateReviewBloc extends Bloc<CreateReviewEvent, CreateReviewState> {
  final ReviewRepository reviewRepository;
  final GetReviewsBloc getReviewsBloc;

  CreateReviewBloc({
    required this.reviewRepository,
    required this.getReviewsBloc,
  }) : super(CreateReviewInitial()) {
    on<CreateReview>(_onCreateReview);
  }

  Future<void> _onCreateReview(
    CreateReview event,
    Emitter<CreateReviewState> emit,
  ) async {
    emit(CreateReviewLoading());

    try {
      final dynamic response = await reviewRepository.createReview(
        serviceId: event.serviceId,
        reviewData: event.reviewData,
      );

      if (response == false) {
        emit(const CreateReviewFailure(error: 'Token error'));
        return;
      }

      // get reviews again after adding a review
      getReviewsBloc.add(GetReviews(serviceId: event.serviceId));

      emit(CreateReviewSuccess());
    } catch (err) {
      emit(CreateReviewFailure(error: err.toString()));
    }
  }
}
