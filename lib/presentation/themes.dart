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
      titleMedium: TextStyle(
        fontSize: 17,
        color: Color(0xFFDDDDDD),
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 15,
        color: Color(0xFFDDDDDD),
        fontWeight: FontWeight.w500,
      ),

      // display
      displaySmall: TextStyle(
        fontSize: 22,
        color: Color(0xFFDDDDDD),
        fontWeight: FontWeight.w600,
      ),
      displayMedium: TextStyle(
        fontSize: 30,
        color: Color(0xFFDDDDDD),
        fontWeight: FontWeight.w700,
      ),
      displayLarge: TextStyle(
        fontSize: 34,
        color: Color(0xFFDDDDDD),
        fontWeight: FontWeight.w600,
      ),

      labelMedium: TextStyle(
        fontSize: 25,
        color: Color(0xFFBBBBBB),
        fontWeight: FontWeight.w400,
      ),

      // container text
      bodySmall: TextStyle(
        fontSize: 12,
        color: Color(0xFFBBBBBB),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFFBBBBBB),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
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
        color: Color(0xFFBBBBBB),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Color(0xFFDDDDDD),
      ),
    ),

    // input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF222222),
      contentPadding: const EdgeInsets.all(padding),
      labelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),

      // border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Color(0xFF444444)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
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
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        // padding: MaterialStateProperty.all(const EdgeInsets.all(padding)),
        elevation: MaterialStateProperty.all(0),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(const EdgeInsets.all(padding)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(const Color(0xFF444444)),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 14,
          ),
        ),
        foregroundColor: MaterialStateProperty.all(
          const Color(0xFFBBBBBB),
        ),
      ),
    ),

    // colorscheme
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF9E9DFF),
      secondary: Color(0xFF222222),
      surface: Color(0xFF222222),
      outline: Color(0xFF444444),
      error: Colors.red,
    ),

    // snackBarTheme
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF222222),
      actionTextColor: Color(0xFFBBBBBB),
      behavior: SnackBarBehavior.floating,
      elevation: 3,
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

      // display
      displaySmall: TextStyle(
        fontSize: 22,
        color: Color(0xFF444444),
        fontWeight: FontWeight.w600,
      ),
      displayMedium: TextStyle(
        fontSize: 30,
        color: Color(0xFF444444),
        fontWeight: FontWeight.w700,
      ),
      displayLarge: TextStyle(
        fontSize: 34,
        color: Color(0xFF444444),
        fontWeight: FontWeight.w600,
      ),

      labelMedium: TextStyle(
        fontSize: 25,
        color: Color(0xFF444444),
        fontWeight: FontWeight.w400,
      ),

      // container text
      bodySmall: TextStyle(
        fontSize: 12,
        color: Color(0xFF444444),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF444444),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
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
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Color(0xFF444444),
      ),
    ),

    // input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFFFFFFF),
      contentPadding: const EdgeInsets.all(padding),
      labelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),

      // border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
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
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        // padding: MaterialStateProperty.all(const EdgeInsets.all(padding)),
        elevation: MaterialStateProperty.all(0),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(const EdgeInsets.all(padding)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 14,
          ),
        ),
        foregroundColor: MaterialStateProperty.all(const Color(0xFF444444)),
      ),
    ),

    // colorscheme
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF9E9DFF),
      secondary: Color(0xFF222222),
      surface: Color(0xFFFFFFFF),
      background: Color(0xFFF2F2F6),
      outline: Color(0xFFDDDDDD),
      error: Colors.red,
    ),

    // snackBarTheme
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      actionTextColor: Color(0xFF222222),
      behavior: SnackBarBehavior.floating,
      elevation: 3,
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
