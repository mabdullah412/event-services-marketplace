import 'package:event_planner/presentation/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(PhosphorIcons.arrowBendUpLeftLight),
                  ),
                  const SizedBox(width: padding),
                  Text(
                    'Settings',
                    style: Theme.of(context).primaryTextTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: padding),
              const ThemeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
