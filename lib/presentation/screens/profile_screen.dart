import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/header.dart';
import '../widgets/toggle_theme_btn.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Header(title: 'Profile'),
            const SizedBox(height: padding),
            Container(
              padding: const EdgeInsets.all(padding),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Theme Mode',
                    style: Theme.of(context).primaryTextTheme.titleSmall,
                  ),
                  const ToggleThemeButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
