import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/order.dart';
import '../../data/models/service.dart';
import '../../logic/bloc/get_orders_bloc.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import 'package_order_service_button.dart';

class OrderDetailsModal extends StatefulWidget {
  /// Modal bottom sheet that shows details of the provided order.

  const OrderDetailsModal({
    required this.order,
    required this.getOrdersBloc,
    required this.getPackagesBloc,
    Key? key,
  }) : super(key: key);

  final Order order;
  final GetOrdersBloc getOrdersBloc;
  final GetPackagesBloc getPackagesBloc;

  @override
  State<OrderDetailsModal> createState() => _OrderDetailsModalState();
}

class _OrderDetailsModalState extends State<OrderDetailsModal> {
  Order get order => widget.order;
  GetOrdersBloc get getOrdersBloc => widget.getOrdersBloc;
  GetPackagesBloc get getPackagesBloc => widget.getPackagesBloc;

  bool deleting = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(padding),
          padding: const EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rs ${order.totalPrice.toDouble()}',
                        style: Theme.of(context).primaryTextTheme.titleLarge,
                      ),
                      const SizedBox(height: padding / 4),
                      Text(
                        'Placed on ${order.createdAt.year}-${order.createdAt.month}-${order.createdAt.day}',
                        style: Theme.of(context).primaryTextTheme.bodySmall,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: deleting == true
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          )
                        : Icon(
                            PhosphorIcons.trash,
                            color: Theme.of(context).colorScheme.error,
                            size: 20,
                          ),
                  ),
                ],
              ),
              const SizedBox(height: padding / 4),
              const Divider(),
              // const SizedBox(height: padding / 4),
              ListView.builder(
                shrinkWrap: true,
                itemCount: order.services.length,
                itemBuilder: (context, index) {
                  final Service service = order.services[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: padding / 2),
                    child: PackageOrderServiceButton(
                      service: service,
                      getPackagesBloc: getPackagesBloc,
                    ),
                  );
                },
              ),
              if (order.services.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: padding / 2),
                  child: Text(
                    'You have not yet added any service in this package.',
                    style: Theme.of(context).primaryTextTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
