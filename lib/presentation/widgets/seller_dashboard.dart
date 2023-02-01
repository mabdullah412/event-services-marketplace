import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'stat_card.dart';

class SellerDashboard extends StatelessWidget {
  const SellerDashboard({
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
            'Seller dashboard',
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          const SizedBox(height: padding),
          IntrinsicHeight(
            child: Row(
              children: const [
                StatCard(title: 'Orders Completed:', value: '5'),
                SizedBox(width: padding),
                StatCard(title: 'Total Sales:', value: 'Rs. 10000.0'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
