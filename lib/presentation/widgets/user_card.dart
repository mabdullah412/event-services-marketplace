import 'package:event_planner/presentation/screens/payment_methods_screen.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../logic/providers/user_data_provider.dart';
import '../router/custom_page_route.dart';
import '../screens/settings_screen.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = Provider.of<UserDataProvider>(
      context,
      listen: false,
    ).getName();

    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.secondary,
                child: Text(
                  name[0],
                  style: Theme.of(context).primaryTextTheme.titleLarge!.apply(
                        color: Theme.of(context).colorScheme.surface,
                        fontSizeDelta: 10,
                      ),
                ),
              ),
              const SizedBox(width: padding),
              Expanded(
                child: Text(
                  name,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).primaryTextTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: padding),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                CustomPageRoute(child: const PaymentMethodsScreen()),
              );
            },
            icon: const Icon(
              PhosphorIcons.cardholderBold,
              size: 20,
            ),
            label: const Text('Payment Methods'),
          ),
          const SizedBox(height: padding),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                CustomPageRoute(child: const SettingsScreen()),
              );
            },
            icon: const Icon(
              PhosphorIcons.gearBold,
              size: 20,
            ),
            label: const Text('Settings'),
          ),
        ],
      ),
    );
  }
}
