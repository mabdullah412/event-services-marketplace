import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';

class ServiceContainer extends StatelessWidget {
  const ServiceContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // seller Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    child: const Icon(PhosphorIcons.userCircle),
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
                constraints: const BoxConstraints(),
                icon: const Icon(PhosphorIcons.dotsThreeVerticalBold),
              ),
            ],
          ),

          // white space
          const SizedBox(height: padding),

          // image
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(radius),
          //   child: Image.network(src),
          // ),

          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          // white space
          const SizedBox(height: padding),

          // details
          Text(
            'Title',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          Text(
            'Price',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          Text(
            'Desc',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          Text(
            'Location',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          Text(
            'Rating',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          Text(
            'labels',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),

          // white space
          // const SizedBox(height: padding),
          const Divider(),
          const SizedBox(height: padding),

          // learn more, save for later, add to package,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Learn more'),
              ),

              // Row
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    icon: const Icon(PhosphorIcons.bookmarkSimple),
                  ),
                  const SizedBox(width: padding),
                  IconButton(
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    icon: const Icon(PhosphorIcons.listPlus),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
