import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding / 2),
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
                    'Muhammad Abdullah',
                    style: Theme.of(context).primaryTextTheme.bodySmall,
                  ),
                  Text(
                    'ST ST ST ST ST',
                    style: Theme.of(context).primaryTextTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: padding / 2),
          Text(
            'It is with great pleasure to announce that our deievery team has once again won the best NPS Score Award!.',
            style: Theme.of(context).primaryTextTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
