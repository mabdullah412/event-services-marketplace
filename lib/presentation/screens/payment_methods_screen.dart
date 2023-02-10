import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../widgets/pop_header.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PopHeader(title: 'Payment methods'),
              const SizedBox(height: padding),
              const PaymentMethod(),
              const SizedBox(height: padding),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(PhosphorIcons.plusBold, size: 20),
                label: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(padding / 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              gradient: LinearGradient(
                transform: const GradientRotation(2),
                colors: [
                  const Color(0xFFFF3CAC).withAlpha(150),
                  const Color(0xFF784BA0).withAlpha(150),
                  const Color(0xFF2B86C5).withAlpha(150),
                ],
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '1234 5678 1234 5678',
                  style: Theme.of(context).primaryTextTheme.bodyLarge,
                ),
                Text(
                  'Rs. 50000.0',
                  style: Theme.of(context).primaryTextTheme.bodySmall!.apply(
                        color:
                            Theme.of(context).primaryTextTheme.bodyLarge!.color,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: padding / 2),
          Text(
            'Muhammad Abdullah',
            style: Theme.of(context).primaryTextTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            'United Bank Limited',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
