import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/review.dart';
import '../../data/repositories/review_repository.dart';
import '../../logic/bloc/get_reviews_bloc.dart';
import 'add_review.dart';
import 'review_card.dart';

class ReviewsContainer extends StatefulWidget {
  const ReviewsContainer({
    required this.serviceId,
    Key? key,
  }) : super(key: key);

  final String serviceId;

  @override
  State<ReviewsContainer> createState() => _ReviewsContainerState();
}

class _ReviewsContainerState extends State<ReviewsContainer> {
  String get serviceId => widget.serviceId;
  final ReviewRepository _reviewRepository = ReviewRepository();
  late GetReviewsBloc _getReviewBloc;

  @override
  void initState() {
    _getReviewBloc = GetReviewsBloc(reviewRepository: _reviewRepository);
    _getReviewBloc.add(GetReviews(serviceId: serviceId));
    super.initState();
  }

  @override
  void dispose() {
    _getReviewBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews',
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
              OutlinedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return AddReview(
                        serviceId: serviceId,
                        getReviewsBloc: _getReviewBloc,
                        reviewRepository: _reviewRepository,
                      );
                    },
                  );
                },
                icon: const Icon(
                  PhosphorIcons.plus,
                  size: 20,
                ),
                label: const Text('Add'),
              ),
            ],
          ),
          BlocBuilder<GetReviewsBloc, GetReviewsState>(
            bloc: _getReviewBloc,
            builder: (context, state) {
              if (state is GetReviewsLoading || state is GetReviewsInitial) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }

              if (state is GetReviewsSuccess) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.reviews.length,
                  itemBuilder: (context, index) {
                    final Review review = state.reviews[index];
                    return ReviewCard(review: review);
                  },
                );
              }

              if (state is GetReviewsFailure) {
                return const ReviewFailurePlaceholder();
              }

              return const Text('Bloc Error');
            },
          ),
        ],
      ),
    );
  }
}

class ReviewFailurePlaceholder extends StatelessWidget {
  const ReviewFailurePlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Error occured while fetching reviews.',
          style: Theme.of(context).primaryTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class NoReviewsPlaceholder extends StatelessWidget {
  const NoReviewsPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '0 Reviews',
          style: Theme.of(context).primaryTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: padding),
        Text(
          'Be the first to review this product.',
          style: Theme.of(context).primaryTextTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
