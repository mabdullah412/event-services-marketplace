import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../router/custom_page_route.dart';
import '../screens/create_service_screen.dart';

class SellServicesContainer extends StatelessWidget {
  const SellServicesContainer({
    Key? key,
  }) : super(key: key);

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
        children: [
          Text(
            'Become a seller',
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          const SizedBox(height: padding),
          Text(
            'Want to earn by selling providing your services?',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          const SizedBox(height: padding),
          Text(
            'How it works',
            style: Theme.of(context).primaryTextTheme.titleSmall,
          ),
          const SizedBox(height: padding),
          Text(
            '1. Create a Gig',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          Text(
            '2. Provide great services',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          Text(
            '3. Get paid',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          const SizedBox(height: padding),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                CustomPageRoute(child: const CreateServiceScreen()),
              );
            },
            child: const Text('Create a Service'),
          )
        ],
      ),
    );
  }
}
