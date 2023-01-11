import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class PackagesContainer extends StatelessWidget {
  const PackagesContainer({
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
          const NoPackagesPlaceholder(),
          const SizedBox(height: padding),
          const PackageCard(),
          const SizedBox(height: padding),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Create a package'),
          ),
        ],
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  const PackageCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Birthday Package',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              '10',
              style: Theme.of(context).primaryTextTheme.bodySmall!.apply(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoPackagesPlaceholder extends StatelessWidget {
  const NoPackagesPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'You have no packages.',
          style: Theme.of(context).primaryTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: padding),
        Text(
          'Packages work like carts, you can add as many items you want in a package and then checkout that package. You can also work with multiple packages at the same time.',
          style: Theme.of(context).primaryTextTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
