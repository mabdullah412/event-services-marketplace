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
                  const Text('Create a package'),
                  const SizedBox(height: padding),
                  const Text(
                    'Create your own custom packages by adding the services you desire and pay for the whole package in one click.',
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
                children: const [
                  Text(
                    'Become a seller',
                    style: TextStyle(color: Color(0xFFF2F2F6)),
                  ),
                  SizedBox(height: padding),
                  Text(
                    'Have services thay you would like to sell? Go to the profile page and turn on seller mode.',
                    style: TextStyle(color: Color(0xFFF2F2F6)),
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
