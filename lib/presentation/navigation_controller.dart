import 'package:event_planner/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'screens/discover_screen.dart';
import 'screens/home_screen.dart';
import 'screens/inbox_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/profile_screen.dart';

class NavigationController extends StatefulWidget {
  const NavigationController({super.key});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int index = 0;

  final screens = const <Widget>[
    HomeScreen(),
    InboxScreen(),
    DiscoverScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  final screenTitles = const <String>[
    'Home',
    'Inbox',
    'Discover',
    'Manage Orders',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  List<Widget> get destinations {
    return const [
      NavigationDestination(
        icon: Icon(PhosphorIcons.houseBold),
        selectedIcon: Icon(PhosphorIcons.houseFill),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(PhosphorIcons.paperPlaneTiltBold),
        selectedIcon: Icon(PhosphorIcons.paperPlaneTiltFill),
        label: 'Inbox',
      ),
      NavigationDestination(
        icon: Icon(PhosphorIcons.magnifyingGlassBold),
        selectedIcon: Icon(PhosphorIcons.magnifyingGlassFill),
        label: 'Discover',
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
