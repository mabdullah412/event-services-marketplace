import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/review.dart';
import '../../data/models/service.dart';
import '../../data/repositories/review_repository.dart';
import '../../logic/bloc/review_bloc.dart';
import '../widgets/pop_header.dart';
import '../widgets/question_answer_card.dart';
import '../widgets/review_card.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({required this.service, super.key});

  final Service service;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const PopHeader(title: 'Details'),
                const SizedBox(height: padding),
                const ImageBanner(),
                const SizedBox(height: padding),
                SellerAndBookmark(sellerName: service.seller.name),
                const SizedBox(height: padding),
                TitleAndDescription(
                  serviceTitle: service.title,
                  serviceDescription: service.description,
                  serviceRating: service.ratingsAverage,
                  totalServiceReviews: service.ratingsQuantity,
                ),
                const SizedBox(height: padding),
                LocationAddress(serviceLocation: service.location),
                const SizedBox(height: padding),
                Pricing(servicePrice: service.price),
                const SizedBox(height: padding),
                ReviewsContainer(serviceId: service.id),
                const SizedBox(height: padding),
                const Quetions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Quetions extends StatelessWidget {
  const Quetions({
    Key? key,
  }) : super(key: key);

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
        children: [
          Text(
            'Questions',
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          const SizedBox(height: padding),
          const QuestionAnswerCard(),
          const SizedBox(height: padding),
          const QuestionAnswerCard(),
        ],
      ),
    );
  }
}

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
          Text(
            'Reviews',
            style: Theme.of(context).primaryTextTheme.titleMedium,
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

class Pricing extends StatelessWidget {
  const Pricing({
    Key? key,
    required this.servicePrice,
  }) : super(key: key);

  final int servicePrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Rs. ${servicePrice.toDouble()}',
            style: Theme.of(context).primaryTextTheme.titleLarge,
          ),
          const SizedBox(height: padding),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Add to package'),
          ),
        ],
      ),
    );
  }
}

class LocationAddress extends StatelessWidget {
  const LocationAddress({
    Key? key,
    required this.serviceLocation,
  }) : super(key: key);

  final String serviceLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
        ),
        color: Theme.of(context).colorScheme.surface,
        image: const DecorationImage(
          image: AssetImage('assets/images/map_background.png'),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
      ),
      child: Center(
        child: TextButton.icon(
          onPressed: () {},
          icon: const Icon(PhosphorIcons.mapPin),
          label: Text(serviceLocation),
        ),
      ),
    );
  }
}

class TitleAndDescription extends StatelessWidget {
  const TitleAndDescription({
    Key? key,
    required this.serviceTitle,
    required this.serviceDescription,
    required this.serviceRating,
    required this.totalServiceReviews,
  }) : super(key: key);

  final String serviceTitle;
  final int serviceRating;
  final int totalServiceReviews;
  final String serviceDescription;

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
        children: [
          Text(
            serviceTitle,
            style: Theme.of(context).primaryTextTheme.displaySmall,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                PhosphorIcons.starFill,
                color: Colors.orange,
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                serviceRating.toString(),
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ),
              const SizedBox(width: padding),
              Text(
                '$totalServiceReviews Reviews',
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyMedium!
                    .apply(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            serviceDescription,
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class SellerAndBookmark extends StatelessWidget {
  const SellerAndBookmark({
    required this.sellerName,
    Key? key,
  }) : super(key: key);

  final String sellerName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.secondary,
                child: const Icon(PhosphorIcons.userCircleLight),
              ),
              const SizedBox(width: padding),
              Text(
                sellerName,
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              PhosphorIcons.bookmarkSimple,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}

class ImageBanner extends StatelessWidget {
  const ImageBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Icon(PhosphorIcons.dotsThreeBold, size: 45)
      ],
    );
  }
}
