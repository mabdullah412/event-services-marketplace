import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/review.dart';
import '../../data/repositories/review_repository.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository reviewRepository;

  ReviewBloc({
    required this.reviewRepository,
  }) : super(ReviewInitial()) {
    on<GetReviews>(_onGetReviews);
  }

  Future<void> _onGetReviews(
    GetReviews event,
    Emitter<ReviewState> emit,
  ) async {
    emit(ReviewLoading());

    try {
      final List<Review> reviews = await reviewRepository.getReviews(
        serviceId: event.serviceId,
      );

      emit(ReviewLoaded(reviews: reviews));
    } catch (err) {
      emit(ReviewFailure(error: err.toString()));
    }
  }
}
