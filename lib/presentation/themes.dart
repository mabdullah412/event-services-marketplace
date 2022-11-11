import 'package:event_planner/constants/constants.dart';
import 'package:flutter/material.dart';

class Themes {
  static final darkTheme = ThemeData(
    // background
    scaffoldBackgroundColor: const Color(0xFF444444),

    // font
    fontFamily: 'Poppins',
    // text -> 0xFFF2F2F6
    primaryTextTheme: TextTheme(),
    textTheme: TextTheme(),

    // buttonthemes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
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
    primaryTextTheme: TextTheme(),
    textTheme: TextTheme(),

    // buttonthemes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
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
