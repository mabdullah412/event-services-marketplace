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
              padding: const EdgeInsets.symmetric(
                horizontal: padding,
                vertical: padding / 2,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Theme Mode'),
                  ToggleThemeButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
