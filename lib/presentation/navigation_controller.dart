import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../constants/constants.dart';
import '../data/repositories/order_repository.dart';
import '../data/repositories/package_repository.dart';
import '../logic/bloc/get_orders_bloc.dart';
import '../logic/bloc/get_packages_bloc.dart';
import 'screens/discover_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/profile_screen.dart';

class NavigationController extends StatefulWidget {
  /// Handles what screen is to be displayed, as it hosts the navigation buttons
  /// required to navigate to different screens.

  const NavigationController({super.key});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int index = 0;
  late GetPackagesBloc _getPackagesBloc;
  late GetOrdersBloc _getOrdersBloc;

  final screens = const <Widget>[
    DiscoverScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  final screenTitles = const <String>[
    'Home',
    'Orders',
    'Profile',
  ];

  @override
  void initState() {
    _getPackagesBloc = GetPackagesBloc(packageRepository: PackageRepository());
    _getOrdersBloc = GetOrdersBloc(orderRepository: OrderRepository());
    super.initState();
  }

  @override
  void dispose() {
    _getPackagesBloc.close();
    _getOrdersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // passing GetPackagesBloc because it is required on multiple screens
        BlocProvider<GetPackagesBloc>(
          create: (context) => _getPackagesBloc,
        ),
        // passing GetOrdersBloc because it is required on multiple screens
        BlocProvider(
          create: (context) => _getOrdersBloc,
        ),
      ],
      child: Scaffold(
        // indexed stack preserves state through page changes
        body: IndexedStack(
          index: index,
          children: screens,
        ),

        // navigation bar
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(padding),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: NavigationBarTheme(
              data: Theme.of(context).navigationBarTheme,
              child: NavigationBar(
                selectedIndex: index,
                onDestinationSelected: (index) {
                  setState(() {
                    this.index = index;
                  });
                },
                destinations: destinations,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get destinations {
    return const [
      NavigationDestination(
        icon: Icon(PhosphorIcons.magnifyingGlassBold),
        selectedIcon: Icon(PhosphorIcons.houseFill),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(PhosphorIcons.scrollBold),
        selectedIcon: Icon(PhosphorIcons.scrollFill),
        label: 'Orders',
      ),
      NavigationDestination(
        icon: Icon(PhosphorIcons.userCircleBold),
        selectedIcon: Icon(PhosphorIcons.userCircleFill),
        label: 'Profile',
      ),
    ];
  }
}
