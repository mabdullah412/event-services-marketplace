import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({
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
        children: [
          Text(
            'Buyer dashboard',
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
