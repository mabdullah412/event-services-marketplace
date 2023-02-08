import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/service.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import '../widgets/add_to_package_modal.dart';
import '../widgets/pop_header.dart';
import '../widgets/question_answer_card.dart';
import '../widgets/reviews_container.dart';

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
                ImageBanner(imageUrl: service.coverImage),
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
                Pricing(
                  serviceId: service.id,
                  servicePrice: service.price,
                  getPackagesBloc: BlocProvider.of<GetPackagesBloc>(context),
                ),
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

class Pricing extends StatelessWidget {
  const Pricing({
    required this.serviceId,
    required this.servicePrice,
    required this.getPackagesBloc,
    Key? key,
  }) : super(key: key);

  final int servicePrice;
  final String serviceId;
  final GetPackagesBloc getPackagesBloc;

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
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return AddToPackageModal(
                    serviceId: serviceId,
                    getPackagesBloc: getPackagesBloc,
                  );
                },
              );
            },
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
              // const SizedBox(width: padding),
              // Text(
              //   '$totalServiceReviews Reviews',
              //   style: Theme.of(context)
              //       .primaryTextTheme
              //       .bodyMedium!
              //       .apply(color: Theme.of(context).colorScheme.primary),
              // ),
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
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     PhosphorIcons.bookmarkSimple,
          //     size: 20,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ImageBanner extends StatelessWidget {
  const ImageBanner({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            padding: const EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Center(
              child: Text(
                'Error occured while fetching image.',
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 50,
            padding: const EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      ),
    );
  }
}
