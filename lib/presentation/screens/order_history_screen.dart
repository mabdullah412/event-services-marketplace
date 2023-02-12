import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../data/models/order.dart';
import '../../data/models/service.dart';
import '../widgets/order_status.dart';
import '../widgets/pop_header.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({
    required this.orders,
    super.key,
  });

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            children: [
              const PopHeader(title: 'Order History'),
              const SizedBox(height: padding),
              ListView.builder(
                shrinkWrap: true,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final Order order = orders[index];

                  return Container(
                    padding: const EdgeInsets.all(padding),
                    margin: const EdgeInsets.only(bottom: padding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(radius),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rs. ${order.totalPrice.toDouble()}',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleLarge,
                                ),
                                const SizedBox(height: padding / 4),
                                Text(
                                  'Placed on ${order.createdAt.year}-${order.createdAt.month}-${order.createdAt.day}',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodySmall,
                                ),
                              ],
                            ),
                            OrderStatus(status: order.status),
                          ],
                        ),
                        const SizedBox(height: padding / 4),
                        const Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: order.services.length,
                          itemBuilder: (context, index) {
                            final Service service = order.services[index];
                            return Container(
                              margin: const EdgeInsets.only(top: padding / 2),
                              padding: const EdgeInsets.all(padding / 2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(radius),
                                ),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    child: Text(
                                      service.quantity.toString(),
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodySmall!
                                          .apply(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: padding),
                                  Text(
                                    service.title,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodySmall,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
