import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Header(title: 'Home'),

              // TODO: ideas for home screen
              // ! add a block showing total number of services being on sale
              // ! user mini-dashboard

              // const SizedBox(height: padding),
              // CreatePackageAndSellFullHeight(),
              SizedBox(height: padding),
              CreatePackageInfo(),
              SizedBox(height: padding),
              SellServicesInfo(),
              SizedBox(height: padding),
              // Squares(),
            ],
          ),
        ),
      ),
    );
  }
}

class CreatePackageAndSellFullHeight extends StatelessWidget {
  const CreatePackageAndSellFullHeight({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: CreatePackageInfo(),
            ),
            SizedBox(width: padding),
            Expanded(
              child: SellServicesInfo(),
            ),
          ],
        ),
      ),
    );
  }
}

class Squares extends StatelessWidget {
  const Squares({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: const EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            ),
          ),
          const SizedBox(width: padding),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: const EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SellServicesInfo extends StatelessWidget {
  const SellServicesInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class CreatePackageInfo extends StatelessWidget {
  const CreatePackageInfo({
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
    );
  }
}
