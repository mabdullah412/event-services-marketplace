import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../logic/providers/theme_provider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Row(
      children: [
        ElevatedButton(
          onPressed: themeProvider.themeMode == ThemeMode.dark
              ? null
              : () {
                  themeProvider.toggleTheme();
                },
          child: const Icon(PhosphorIcons.moonFill),
        ),
        const SizedBox(width: padding),
        ElevatedButton(
          onPressed: themeProvider.themeMode == ThemeMode.light
              ? null
              : () {
                  themeProvider.toggleTheme();
                },
          child: const Icon(PhosphorIcons.sunFill),
        ),
      ],
    );
  }
}
