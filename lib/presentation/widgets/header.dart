import 'package:event_planner/logic/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeProvider>(context).themeMode;

    return Text(
      title,
      style: TextStyle(
        fontSize: 19,
        color: themeMode == ThemeMode.dark
            ? const Color(0xFFDDDDDD)
            : const Color(0xFF444444),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
