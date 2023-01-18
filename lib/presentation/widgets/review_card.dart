import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/review.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    required this.review,
    Key? key,
  }) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding / 2),
      margin: const EdgeInsets.only(top: padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.secondary,
                child: const Icon(PhosphorIcons.userCircleLight),
              ),
              const SizedBox(width: padding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.author.name,
                    style: Theme.of(context).primaryTextTheme.bodySmall,
                  ),
                  Text(
                    review.rating.toString(),
                    style: Theme.of(context).primaryTextTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: padding / 2),
          Text(
            review.review,
            style: Theme.of(context).primaryTextTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
