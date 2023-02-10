import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/order.dart';
import '../../logic/bloc/get_orders_bloc.dart';
import '../../logic/bloc/get_packages_bloc.dart';
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
          BlocBuilder<GetOrdersBloc, GetOrdersState>(
            bloc: _getOrdersBloc,
            builder: (context, state) {
              if (state is GetOrdersLoading || state is GetOrdersInitial) {
                return const Padding(
                  padding: EdgeInsets.only(top: padding, bottom: padding),
                  child: Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              }

              if (state is GetOrdersSuccess) {
                if (state.orders.isEmpty) {
                  return const NoOrdersPlaceholder();
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    final Order order = state.orders[index];
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
                );
              }

              if (state is GetOrdersFailure) {
                return const GetOrdersFailurePlaceholder();
              }

              return const Text('bloc error');
            },
          ),
          const SizedBox(height: padding / 2),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(PhosphorIcons.calendarCheckBold, size: 20),
            label: const Text('View previous orders'),
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
