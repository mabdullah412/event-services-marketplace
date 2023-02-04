import 'package:flutter/material.dart';

import '../../data/models/order.dart';
import '../../logic/bloc/get_orders_bloc.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import 'order_details_modal.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    required this.order,
    required this.getOrdersBloc,
    required this.getPackagesBloc,
    Key? key,
  }) : super(key: key);

  final Order order;
  final GetOrdersBloc getOrdersBloc;
  final GetPackagesBloc getPackagesBloc;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return OrderDetailsModal(
              order: order,
              getOrdersBloc: getOrdersBloc,
              getPackagesBloc: getPackagesBloc,
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: 'Order # ',
              style: Theme.of(context).primaryTextTheme.bodyMedium,
              children: [
                TextSpan(
                  text:
                      '${order.createdAt.year}-${order.createdAt.month}-${order.createdAt.day}',
                  style: Theme.of(context).primaryTextTheme.bodyMedium!.apply(
                        fontWeightDelta: 2,
                      ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Rs. ',
              style: Theme.of(context).primaryTextTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '${order.totalPrice}',
                  style: Theme.of(context).primaryTextTheme.bodyMedium!.apply(
                        fontWeightDelta: 2,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
