import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/review.dart';
import '../../data/repositories/review_repository.dart';
import '../../logic/bloc/review_bloc.dart';
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
  late ReviewBloc _reviewBloc;

  @override
  void initState() {
    _reviewBloc = ReviewBloc(reviewRepository: ReviewRepository());
    _reviewBloc.add(GetReviews(serviceId: serviceId));
    super.initState();
  }

  @override
  void dispose() {
    _reviewBloc.close();
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
                      return const AddReview();
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
          BlocBuilder<ReviewBloc, ReviewState>(
            bloc: _reviewBloc,
            builder: (context, state) {
              if (state is ReviewLoading || state is ReviewInitial) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }

              if (state is ReviewLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.reviews.length,
                  itemBuilder: (context, index) {
                    final Review review = state.reviews[index];
                    return ReviewCard(review: review);
                  },
                );
              }

              if (state is ReviewFailure) {
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

class AddReview extends StatefulWidget {
  const AddReview({
    Key? key,
  }) : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final Map<dynamic, dynamic> reviewData = {};
  int selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(padding),
          padding: const EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add a review',
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
              const SizedBox(height: padding),
              Container(
                padding: const EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(radius),
                  ),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingButton(
                      value: 1,
                      isSelected: selectedRating == 1,
                      onPressed: () {
                        setState(() {
                          selectedRating = 1;
                        });
                      },
                    ),
                    Expanded(child: Container()),
                    RatingButton(
                      value: 2,
                      isSelected: selectedRating == 2,
                      onPressed: () {
                        setState(() {
                          selectedRating = 2;
                        });
                      },
                    ),
                    Expanded(child: Container()),
                    RatingButton(
                      value: 3,
                      isSelected: selectedRating == 3,
                      onPressed: () {
                        setState(() {
                          selectedRating = 3;
                        });
                      },
                    ),
                    Expanded(child: Container()),
                    RatingButton(
                      value: 4,
                      isSelected: selectedRating == 4,
                      onPressed: () {
                        setState(() {
                          selectedRating = 4;
                        });
                      },
                    ),
                    Expanded(child: Container()),
                    RatingButton(
                      value: 5,
                      isSelected: selectedRating == 5,
                      onPressed: () {
                        setState(() {
                          selectedRating = 5;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: padding),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Description'),
                ),
              ),
              const SizedBox(height: padding),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RatingButton extends StatelessWidget {
  const RatingButton({
    required this.value,
    required this.isSelected,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final int value;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: OutlinedButton(
        onPressed: onPressed,
        style: isSelected
            ? ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary,
                ),
                foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary,
                ),
              )
            : const ButtonStyle(),
        child: Text(value.toString()),
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
