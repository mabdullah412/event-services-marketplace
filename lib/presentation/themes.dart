import 'package:flutter/material.dart';

class Themes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF444444),
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 55,
      elevation: 0,
      backgroundColor: const Color(0xFF333333),
      indicatorColor: const Color.fromARGB(0, 0, 0, 0),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      iconTheme: MaterialStateProperty.all(
        const IconThemeData(
          size: 22,
          color: Color(0xFFDDDDDD),
        ),
      ),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF2F2F6),
    colorScheme: const ColorScheme.light(),
    navigationBarTheme: NavigationBarThemeData(
      height: 55,
      elevation: 0,
      backgroundColor: const Color(0xFFFFFFFF),
      indicatorColor: const Color.fromARGB(0, 0, 0, 0),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      iconTheme: MaterialStateProperty.all(
        const IconThemeData(
          size: 22,
          color: Color(0xFF444444),
        ),
      ),
    ),
  );
}
