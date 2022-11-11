import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Header(title: 'Home'),

            const SizedBox(height: padding),

            // * create a package
            Container(
              padding: const EdgeInsets.all(padding),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Create a package',
                    style: Theme.of(context).primaryTextTheme.titleMedium,
                  ),
                  const SizedBox(height: padding),
                  Text(
                    'Create your own custom packages by adding the services you desire and pay for the whole package in one click.',
                    style: Theme.of(context).primaryTextTheme.bodyMedium,
                  ),
                  const SizedBox(height: padding),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Sell a Service'),
                  )
                ],
              ),
            ),

            const SizedBox(height: padding),

            // * sell services
            Container(
              padding: const EdgeInsets.all(padding),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Become a seller',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: padding),
                  Text(
                    'Have services thay you would like to sell? Go to the profile page and turn on seller mode.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
