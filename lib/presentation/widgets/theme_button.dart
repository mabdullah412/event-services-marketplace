import 'package:event_planner/constants/constants.dart';
import 'package:event_planner/presentation/widgets/toggle_theme_btn.dart';
import 'package:flutter/material.dart';

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
