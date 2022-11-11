import 'package:flutter/material.dart';

import '../constants/constants.dart';

class Themes {
  static final darkTheme = ThemeData(
    // background
    scaffoldBackgroundColor: const Color(0xFF444444),

    // font
    fontFamily: 'Poppins',

    // text -> 0xFFF2F2F6
    // primary text
    primaryTextTheme: const TextTheme(
      // header
      titleLarge: TextStyle(
        fontSize: 19,
        color: Color(0xFFDDDDDD),
        fontWeight: FontWeight.w600,
      ),

      // container
      titleMedium: TextStyle(
        fontSize: 17,
        color: Color(0xFFDDDDDD),
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 15,
        color: Color(0xFFDDDDDD),
        fontWeight: FontWeight.w600,
      ),

      // container text
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFFDDDDDD),
      ),
    ),

    // secondary text
    textTheme: const TextTheme(
      // container
      titleMedium: TextStyle(
        fontSize: 17,
        color: Color(0xFFDDDDDD),
        fontWeight: FontWeight.w500,
      ),

      // container text
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFFDDDDDD),
      ),
    ),

    // buttonthemes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(const EdgeInsets.all(padding)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    ),

    // colorscheme
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF9E9DFF),
      secondary: Color(0xFF222222),
      surface: Color(0xFF222222),
    ),

    // navbar
    navigationBarTheme: NavigationBarThemeData(
      height: 55,
      elevation: 0,
      backgroundColor: const Color(0xFF333333),
      indicatorColor: const Color.fromARGB(0, 0, 0, 0),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      iconTheme: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(
              size: 22,
              color: Color(0xFF9E9DFF),
            );
          }
          return const IconThemeData(
            size: 22,
            color: Color(0xFFDDDDDD),
          );
        },
      ),
    ),
  );

  static final lightTheme = ThemeData(
    // background
    scaffoldBackgroundColor: const Color(0xFFF2F2F6),

    // font
    fontFamily: 'Poppins',

    // primary text
    primaryTextTheme: const TextTheme(
      // header
      titleLarge: TextStyle(
        fontSize: 19,
        color: Color(0xFF444444),
        fontWeight: FontWeight.w600,
      ),

      // container
      titleMedium: TextStyle(
        fontSize: 17,
        color: Color(0xFF444444),
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontSize: 15,
        color: Color(0xFF444444),
        fontWeight: FontWeight.w600,
      ),

      // container text
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF444444),
      ),
    ),

    // secondary text
    textTheme: const TextTheme(
      // container
      titleMedium: TextStyle(
        fontSize: 17,
        color: Color(0xFFDDDDDD),
        fontWeight: FontWeight.w600,
      ),

      // container text
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFFDDDDDD),
      ),
    ),

    // buttonthemes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(const EdgeInsets.all(padding)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    ),

    // colorscheme
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF9E9DFF),
      secondary: Color(0xFF222222),
      surface: Color(0xFFFFFFFF),
    ),

    // navbar
    navigationBarTheme: NavigationBarThemeData(
      height: 55,
      elevation: 0,
      backgroundColor: const Color(0xFFFFFFFF),
      indicatorColor: const Color.fromARGB(0, 0, 0, 0),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      iconTheme: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(
              size: 22,
              color: Color(0xFF9E9DFF),
            );
          }
          return const IconThemeData(
            size: 22,
            color: Color(0xFF444444),
          );
        },
      ),
    ),
  );
}
