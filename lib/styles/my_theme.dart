import 'package:flutter/material.dart';
import 'package:todo/styles/app_colors.dart';
import 'package:todo/styles/text_style.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    iconTheme: const IconThemeData(
      size: 30,
      color: AppCloros.lightColor,
    ),
    scaffoldBackgroundColor: AppCloros.lightGreenColor,
    primaryColor: AppCloros.lightColor,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 30,
      ),
      color: AppCloros.lightColor,
      centerTitle: false,
    ),
    textTheme: TextTheme(
      bodySmall: AppTexts.NovaSquare12BlackLight(),
      bodyMedium: AppTexts.NovaSquare18WhiteLight(),
      bodyLarge: AppTexts.NovaSquare22WhiteLight(),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppCloros.lightColor,
      unselectedItemColor: Colors.grey.shade500,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    iconTheme: const IconThemeData(
      size: 30,
      color: Colors.white,
    ),
    scaffoldBackgroundColor: AppCloros.darkColor,
    primaryColorDark: AppCloros.lightColor,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 30,
      ),
      color: AppCloros.lightColor,
      centerTitle: false,
    ),
    textTheme: TextTheme(
      bodySmall: AppTexts.NovaSquare12WhiteDark(),
      bodyMedium: AppTexts.NovaSquare18WhiteDark(),
      bodyLarge: AppTexts.NovaSquare22WhiteDark(),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppCloros.lightColor,
        unselectedItemColor: Colors.white),
  );
}
