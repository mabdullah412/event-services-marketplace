import 'package:flutter/material.dart';

import '../../data/models/package.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    required this.package,
    Key? key,
  }) : super(key: key);

  final Package package;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            package.name,
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              package.services.length.toString(),
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
