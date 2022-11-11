import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/providers/theme_provider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDartMode,
      onChanged: (value) {
        themeProvider.toggleTheme();
      },
    );
  }
}
