import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../logic/providers/theme_provider.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

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
