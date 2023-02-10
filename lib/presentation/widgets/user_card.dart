import 'package:event_planner/logic/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../router/custom_page_route.dart';
import '../screens/settings_screen.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = Provider.of<UserDataProvider>(context, listen: false).getName();

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
                child: const Icon(PhosphorIcons.userCircleLight, size: 40),
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
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                CustomPageRoute(child: const SettingsScreen()),
              );
            },
            child: const Text('Settings'),
          )
        ],
      ),
    );
  }
}
