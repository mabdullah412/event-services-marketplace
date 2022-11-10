import 'package:event_planner/logic/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(title: 'Home'),
            const SizedBox(height: padding),
            ElevatedButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(true);
              },
              child: const Text('To Dark'),
            ),
            const SizedBox(height: padding),
            ElevatedButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(false);
              },
              child: const Text('To Light'),
            ),
          ],
        ),
      ),
    );
  }
}
