import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../constants/enums.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/service_repository.dart';
import '../../logic/bloc/get_seller_orders_bloc.dart';
import '../../logic/bloc/get_user_services_bloc.dart';
import '../router/custom_page_route.dart';
import '../screens/create_service_screen.dart';
import '../screens/user_services_screen.dart';
import 'complete_orders_button.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  late GetUserServicesBloc _getUserServicesBloc;
  late GetSellerOrdersBloc _getSellerOrdersBloc;

  @override
  void initState() {
    _getUserServicesBloc = GetUserServicesBloc(
      serviceRepository: ServiceRepository(),
    );
    _getSellerOrdersBloc = GetSellerOrdersBloc(
      orderRepository: OrderRepository(),
    );
    _getSellerOrdersBloc.add(GetSellerOrders());
    super.initState();
  }

  @override
  void dispose() {
    _getUserServicesBloc.close();
    _getSellerOrdersBloc.close();
    super.dispose();
  }

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
          // const SizedBox(height: padding),
          // IntrinsicHeight(
          //   child: Row(
          //     children: const [
          //       Expanded(
          //         child: StatCard(title: 'Orders completed:', value: '2'),
          //       ),
          //       SizedBox(width: padding),
          //       Expanded(
          //         child: StatCard(title: 'Total Earned:', value: 'Rs. 50,000'),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: padding),
          BlocBuilder<GetSellerOrdersBloc, GetSellerOrdersState>(
            bloc: _getSellerOrdersBloc,
            builder: (context, state) {
              if (state is GetSellerOrdersLoading ||
                  state is GetSellerOrdersInitial) {
                return Container(
                  padding: const EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(radius),
                    ),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  child: const Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                );
              }

              if (state is GetSellerOrdersSuccess) {
                return CompleteOrdersButton(
                  getSellerOrdersBloc: _getSellerOrdersBloc,
                  ordersLeft: state.orders
                      .where(
                        (order) => order.status == Status.pending,
                      )
                      .toList()
                      .length,
                );
              }

              return const Text('Bloc Error');
            },
          ),
          const SizedBox(height: padding),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                CustomPageRoute(
                  child: UserServicesScreen(
                    getUserServicesBloc: _getUserServicesBloc,
                  ),
                ),
              );
            },
            icon: const Icon(PhosphorIcons.stackSimpleBold, size: 20),
            label: const Text('View your services'),
          ),
          const SizedBox(height: padding),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                CustomPageRoute(
                  child: CreateServiceScreen(
                    getUserServicesBloc: _getUserServicesBloc,
                  ),
                ),
              );
            },
            icon: const Icon(PhosphorIcons.plusBold, size: 20),
            label: const Text('Create a service'),
          ),
        ],
      ),
    );
  }
}
