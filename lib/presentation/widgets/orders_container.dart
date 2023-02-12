import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../constants/enums.dart';
import '../../data/models/order.dart';
import '../../logic/bloc/get_orders_bloc.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import '../router/custom_page_route.dart';
import '../screens/order_history_screen.dart';
import 'order_card.dart';

class OrdersContainer extends StatefulWidget {
  const OrdersContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersContainer> createState() => _OrdersContainerState();
}

class _OrdersContainerState extends State<OrdersContainer> {
  late GetOrdersBloc _getOrdersBloc;

  // if not true: GetOrdersState was not Success
  // bool loadedPreviousOrders = false;
  // List<Order> pendingOrders = <Order>[];
  // List<Order> previousOrders = <Order>[];

  @override
  void initState() {
    _getOrdersBloc = BlocProvider.of<GetOrdersBloc>(context);
    _getOrdersBloc.add(GetOrders());
    super.initState();
  }

  @override
  void dispose() {
    _getOrdersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocConsumer<GetOrdersBloc, GetOrdersState>(
            bloc: _getOrdersBloc,
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // get order loading/initial
                  if (state is GetOrdersLoading || state is GetOrdersInitial)
                    const Padding(
                      padding: EdgeInsets.only(top: padding, bottom: padding),
                      child: Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),

                  // get orders success
                  if (state is GetOrdersSuccess)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.orders
                          .where((order) => order.status == Status.pending)
                          .toList()
                          .length,
                      itemBuilder: (context, index) {
                        // ! in-efficient calculation,
                        // ! goes through the array at every iteration
                        final Order order = state.orders
                            .where((order) => order.status == Status.pending)
                            .toList()[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: padding / 2),
                          child: OrderCard(
                            order: order,
                            getOrdersBloc: _getOrdersBloc,
                            getPackagesBloc:
                                BlocProvider.of<GetPackagesBloc>(context),
                          ),
                        );
                      },
                    ),

                  // get orders failure
                  if (state is GetOrdersFailure)
                    const GetOrdersFailurePlaceholder(),

                  const SizedBox(height: padding / 2),
                  ElevatedButton.icon(
                    onPressed: state is GetOrdersSuccess
                        ? () {
                            Navigator.of(context).push(
                              CustomPageRoute(
                                child: OrderHistoryScreen(
                                  orders: state.orders
                                      .where((order) =>
                                          order.status != Status.pending)
                                      .toList(),
                                ),
                              ),
                            );
                          }
                        : null,
                    icon: const Icon(PhosphorIcons.calendarCheckBold, size: 20),
                    label: const Text('View previous orders'),
                  ),
                ],
              );
            },
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
          'There are no orders placed yet.',
          style: Theme.of(context).primaryTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class GetOrdersFailurePlaceholder extends StatelessWidget {
  const GetOrdersFailurePlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Error occured while fetching orders.',
          style: Theme.of(context).primaryTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
