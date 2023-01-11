import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../widgets/question_answer_card.dart';
import '../widgets/review_card.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                PopHeader(),
                SizedBox(height: padding),
                ImageBanner(),
                SizedBox(height: padding),
                SellerAndBookmark(),
                SizedBox(height: padding),
                TitleAndDescription(),
                SizedBox(height: padding),
                LocationAddress(),
                SizedBox(height: padding),
                Pricing(),
                SizedBox(height: padding),
                Reviews(),
                SizedBox(height: padding),
                Quetions(),
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

class Reviews extends StatelessWidget {
  const Reviews({
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
            'Reviews',
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          const SizedBox(height: padding),
          const ReviewCard(),
          const SizedBox(height: padding),
          const ReviewCard(),
        ],
      ),
    );
  }
}

class Pricing extends StatelessWidget {
  const Pricing({
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Rs. 4,999.0',
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
  }) : super(key: key);

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
          label: const Text(
            'Formanites Housing Society, Lidher Road, Lahore.',
          ),
        ),
      ),
    );
  }
}

class TitleAndDescription extends StatelessWidget {
  const TitleAndDescription({
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
            'Sony WH-1000XM4',
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
                '4.8',
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ),
              const SizedBox(width: padding),
              Text(
                '139 Reviews',
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyMedium!
                    .apply(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'The intuitive and intelligent WH-1000XM4 headphones bring you new improvements in industry-leading noise cancelling technology.',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class SellerAndBookmark extends StatelessWidget {
  const SellerAndBookmark({
    Key? key,
  }) : super(key: key);

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
                'Seller Name',
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

class PopHeader extends StatelessWidget {
  const PopHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(PhosphorIcons.arrowBendUpLeftLight),
        ),
        const SizedBox(width: padding),
        Text(
          'Details',
          style: Theme.of(context).primaryTextTheme.titleLarge,
        ),
      ],
    );
  }
}
