import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/review.dart';
import '../../data/repositories/review_repository.dart';

part 'get_reviews_event.dart';
part 'get_reviews_state.dart';

class GetReviewsBloc extends Bloc<GetReviewsEvent, GetReviewsState> {
  final ReviewRepository reviewRepository;

  GetReviewsBloc({
    required this.reviewRepository,
  }) : super(GetReviewsInitial()) {
    on<GetReviews>(_onGetReviews);
  }

  Future<void> _onGetReviews(
    GetReviews event,
    Emitter<GetReviewsState> emit,
  ) async {
    emit(GetReviewsLoading());

    try {
      final List<Review> reviews = await reviewRepository.getReviews(
        serviceId: event.serviceId,
      );

      emit(GetReviewsSuccess(reviews: reviews));
    } catch (err) {
      emit(GetReviewsFailure(error: err.toString()));
    }
  }
}
