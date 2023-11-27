import 'package:flutter/material.dart';

class MyTheme {
  static Map<int, Color> color = const {
    50: Color.fromRGBO(1, 50, 154, .1),
    100: Color.fromRGBO(1, 50, 154, .2),
    200: Color.fromRGBO(1, 50, 154, .3),
    300: Color.fromRGBO(1, 50, 154, .4),
    400: Color.fromRGBO(1, 50, 154, .5),
    500: Color.fromRGBO(1, 50, 154, .6),
    600: Color.fromRGBO(1, 50, 154, .7),
    700: Color.fromRGBO(1, 50, 154, .8),
    800: Color.fromRGBO(1, 50, 154, .9),
    900: Color.fromRGBO(1, 50, 154, 1),
  };
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Poppins",
    primarySwatch: MaterialColor(MyColor.primary.value, color),
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: MyColor.primary,
        onPrimary: MyColor.onPrimary,
        secondary: MyColor.secondary,
        onSecondary: MyColor.onSecondary,
        error: MyColor.error,
        onError: MyColor.onError,
        background: MyColor.background,
        onBackground: MyColor.onBackground,
        surface: MyColor.background,
        onSurface: MyColor.onBackground,
    ),

    //ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            fixedSize: const Size.fromHeight(51))),


    //OutLineButton
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            // side: BorderSide(color: MyColor.black, width: 1),
            textStyle:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            fixedSize: const Size.fromHeight(62))),
  );
}

class MyColor {
  static Color primary = const Color(0xFFFFFFFF);
  static Color onPrimary = const Color(0xFF000000);
  static Color background = const Color(0xFF0C0C0C);
  static Color onBackground = const Color(0xFFFFFFFF);
  static Color error = const Color(0xFFFA0000);
  static Color onError = const Color(0xFFFFFFFF);
  static Color secondary = const Color(0xFF1E1E1E);
  static Color onSecondary = const Color(0xFF878787);
  static Color lightGrey = const Color(0xFFEAEAEA);
  static Color blue = const Color(0xFF1226DC);
  static Color lightBlue = const Color(0xFF4576D6);
  static Color grey = const Color(0xFFD9D9D9);
  static Color themeBlue = const Color(0xFF0566E9);
  static Color green = const Color(0xFF4CF85D);
  static Color greyCircle = const Color(0xFFC0C0C0);
  static Color greyBack = const Color(0xFFF2F2F2);
  static Color colorA = const Color(0xFF805CF5);
  static Color colorB = const Color(0xFF1A1917);
  static Color colorC = const Color(0xFFD679E7);
  static Color colorD = const Color(0xFFDD8680);
  static Color colorE = const Color(0xFF76B3F4);
  static Color colorF = const Color(0xFF9F3D37);
}
