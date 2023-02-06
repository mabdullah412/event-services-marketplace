import 'package:event_planner/data/repositories/order_repository.dart';
import 'package:event_planner/logic/bloc/cancel_order_bloc.dart';
import 'package:event_planner/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  // getPackagesBloc is needed in service screen.
  GetPackagesBloc get getPackagesBloc => widget.getPackagesBloc;
  late CancelOrderBloc _cancelOrderBloc;

  bool dissableOnPressed = false;

  @override
  void initState() {
    _cancelOrderBloc = CancelOrderBloc(
      orderRepository: OrderRepository(),
      getOrdersBloc: getOrdersBloc,
    );
    super.initState();
  }

  @override
  void dispose() {
    _cancelOrderBloc.close();
    super.dispose();
  }

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
                  BlocConsumer<CancelOrderBloc, CancelOrderState>(
                    bloc: _cancelOrderBloc,
                    listenWhen: (previous, current) => previous != current,
                    listener: (context, state) {
                      if (state is CancelOrderSuccess) {
                        _onWidgetDidBuild(() {
                          // _onWidgetDidBuild displays snackbar after
                          // Build() has finished building
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                label: 'close',
                                onPressed: () {},
                              ),
                              content: const CustomSnackbar(
                                title: 'Success',
                                description: 'Order cancelled successfully',
                                snackbarType: SnackbarType.success,
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        });
                      }

                      if (state is CancelOrderFailure) {
                        _onWidgetDidBuild(() {
                          // _onWidgetDidBuild displays snackbar after
                          // Build() has finished building
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                label: 'close',
                                onPressed: () {},
                              ),
                              content: const CustomSnackbar(
                                title: 'Error',
                                description:
                                    'Error occured while cancelling order',
                                snackbarType: SnackbarType.error,
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        });
                      }
                    },
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            dissableOnPressed = true;
                          });

                          _cancelOrderBloc.add(
                            CancelOrder(orderId: order.id),
                          );
                        },
                        icon: dissableOnPressed == true
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
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: padding / 4),
              const Divider(),
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

  void _onWidgetDidBuild(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callback();
    });
  }
}
