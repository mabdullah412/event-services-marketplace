import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class OrdersContainer extends StatelessWidget {
  const OrdersContainer({
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
        children: const [
          NoOrdersPlaceholder(),
          SizedBox(height: padding),
          OrderCard(),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
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
            'Order # 28/06/2022',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          Text(
            'Rs. 4999.0',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class NoOrdersPlaceholder extends StatelessWidget {
  const NoOrdersPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'You have not placed an order yet.',
          style: Theme.of(context).primaryTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
