import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.bodySmall,
          ),
          const SizedBox(height: padding / 4),
          Text(
            value,
            style: Theme.of(context).primaryTextTheme.titleSmall!.apply(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}
