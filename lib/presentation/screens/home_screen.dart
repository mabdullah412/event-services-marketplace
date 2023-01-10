import 'package:event_planner/presentation/router/custom_page_route.dart';
import 'package:event_planner/presentation/screens/create_service_screen.dart';
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

              SizedBox(height: padding),
              Squares(),

              // CreatePackageAndSellFullHeight(),

              SizedBox(height: padding),
              ShowCreatePackage(),
              SizedBox(height: padding),
              ShowSellServices(),
              SizedBox(height: padding),
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
              child: ShowCreatePackage(),
            ),
            SizedBox(width: padding),
            Expanded(
              child: ShowSellServices(),
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
              aspectRatio: 1.4,
              child: Container(
                padding: const EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Total Services',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const Text(
                      '45',
                      style: TextStyle(
                        fontSize: 40,
                        height: 1,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: padding),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.4,
              child: Container(
                padding: const EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowSellServices extends StatelessWidget {
  const ShowSellServices({
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

class ShowCreatePackage extends StatelessWidget {
  const ShowCreatePackage({
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
            child: const Text('Create a package'),
          )
        ],
      ),
    );
  }
}
