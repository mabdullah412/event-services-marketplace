import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/repositories/service_repository.dart';
import '../../logic/bloc/get_user_services_bloc.dart';
import '../router/custom_page_route.dart';
import '../screens/create_service_screen.dart';
import '../screens/user_services_screen.dart';
import 'stat_card.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  late GetUserServicesBloc _getUserServicesBloc;

  @override
  void initState() {
    _getUserServicesBloc = GetUserServicesBloc(
      serviceRepository: ServiceRepository(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _getUserServicesBloc.close();
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
          const SizedBox(height: padding),
          IntrinsicHeight(
            child: Row(
              children: const [
                Expanded(
                  child: StatCard(title: 'Orders completed:', value: '2'),
                ),
                SizedBox(width: padding),
                Expanded(
                  child: StatCard(title: 'Total Earned:', value: 'Rs. 50,000'),
                ),
              ],
            ),
          ),
          const SizedBox(height: padding),
          const CompleteOrdersButton(ordersLeft: 1),
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

class CompleteOrdersButton extends StatelessWidget {
  const CompleteOrdersButton({
    required this.ordersLeft,
    Key? key,
  }) : super(key: key);

  final int ordersLeft;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
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
              style: Theme.of(context).primaryTextTheme.bodySmall!.apply(
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
