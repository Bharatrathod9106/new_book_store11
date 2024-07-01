import 'package:flutter/material.dart';

import 'colors.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) =>
      ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: backgroudColor,
          secondary: secondryColor,
          onSecondary: backgroudColor,
          error: Colors.red,
          onError: fontColor,
          surface: backgroudColor,
          onSurface: fontColor,
          onPrimaryContainer: secondLebelColor,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontFamily: "Poppins",
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          headlineMedium: TextStyle(
            fontFamily: "Poppins",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          labelLarge: TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: lebelColor,
          ),
          labelMedium: TextStyle(
              fontFamily: "Poppins",
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: lebelColor),
          labelSmall: TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: lebelColor),
        ),
      );
  static ThemeData darkTheme(BuildContext context) =>
      ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: D_primaryColor,
          onPrimary: D_backgroudColor,
          secondary: D_secondryColor,
          onSecondary: D_backgroudColor,
          error: Colors.red,
          onError: D_fontColor,
          surface: D_backgroudColor ,
          onSurface: D_fontColor,
          onPrimaryContainer: secondLebelColor,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontFamily: "Poppins",
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          headlineMedium: TextStyle(
            fontFamily: "Poppins",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          labelLarge: TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: D_lebelColor,
          ),
          labelMedium: TextStyle(
              fontFamily: "Poppins",
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: D_lebelColor),
          labelSmall: TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: D_lebelColor),
        ),
      );
}
