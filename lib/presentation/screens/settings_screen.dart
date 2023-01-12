import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/pop_header.dart';
import '../widgets/theme_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            children: const [
              PopHeader(title: 'Settings'),
              SizedBox(height: padding),
              ThemeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
