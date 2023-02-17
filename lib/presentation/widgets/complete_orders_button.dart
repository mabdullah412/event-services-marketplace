import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../logic/bloc/get_seller_orders_bloc.dart';
import '../router/custom_page_route.dart';
import '../screens/complete_orders_screen.dart';

class CompleteOrdersButton extends StatelessWidget {
  const CompleteOrdersButton({
    required this.getSellerOrdersBloc,
    required this.ordersLeft,
    Key? key,
  }) : super(key: key);

  final GetSellerOrdersBloc getSellerOrdersBloc;
  final int ordersLeft;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          CustomPageRoute(
            child: CompleteOrdersScreen(
              getSellerOrdersBloc: getSellerOrdersBloc,
            ),
          ),
        );
      },
      icon: const Icon(PhosphorIcons.checkSquare, size: 40),
      label: Column(
        children: [
          Text(
            'Complete Orders',
            style: Theme.of(context).primaryTextTheme.bodyLarge,
          ),
          RichText(
            text: TextSpan(
              text: ordersLeft.toString(),
              style: Theme.of(context).primaryTextTheme.bodyMedium!.apply(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeightDelta: 2,
                  ),
              children: [
                TextSpan(
                  text: ordersLeft == 1
                      ? ' order left to complete.'
                      : ' orders left to complete.',
                  style: Theme.of(context).primaryTextTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
