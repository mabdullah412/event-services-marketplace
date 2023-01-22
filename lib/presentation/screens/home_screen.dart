import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../data/repositories/service_repository.dart';
import '../../logic/bloc/get_user_services_bloc.dart';
import '../widgets/header.dart';
import '../widgets/sell_services_container.dart';
import '../widgets/user_services_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // creating an instance of GetUserServicesBloc in home screen,
  // bcz the same instance is needed to be passed to both
  // CreateServiceScreen and UserServicesContainer
  final ServiceRepository serviceRepository = ServiceRepository();
  late GetUserServicesBloc _getUserServicesBloc;

  @override
  void initState() {
    _getUserServicesBloc = GetUserServicesBloc(
      serviceRepository: serviceRepository,
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Header(title: 'Home'),

              // ! add a block showing total number of services being on sale
              // ! open fiverr website for ideas
              // ! user mini-dashboard

              // ! maybe create a single bloc that gets all user
              // ! dashboard data. => getUserDashboard
              // ! the dashboard will contain all the above mentioned
              // ! things.

              // SizedBox(height: padding),
              // Dashboard(),

              const SizedBox(height: padding),
              const ShowCreatePackage(),
              const SizedBox(height: padding),
              UserServicesContainer(
                getUserServicesBloc: _getUserServicesBloc,
              ),
              const SizedBox(height: padding),
              SellServicesContainer(
                getUserServicesBloc: _getUserServicesBloc,
              ),
              const SizedBox(height: padding),
            ],
          ),
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({
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
