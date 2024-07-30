import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  const primaryColor = Color(0xffFBC10D);
  const primaryColorDark = Color(0xffEDB300);
  const primaryColorLight = Color(0xffFFCD33);
  const secondaryColor = Color(0xff00ADEF);
  const secondaryColorDark = Color(0xff009DD9);
  const secondaryColorLight = Color(0xff33C7FF);
  const disabledColor = Color(0xffE2E2E2);
  const dividerColor = Colors.grey;
  const dangerColor = Color(0xffFF5252);
  // const successColor = Color(0xff5EE55B);
  const backgroundColor = Color(0xfff5f5f5);

  const textTheme = TextTheme(
      headline1: TextStyle(
        fontSize: 48,
      ),
      headline2: TextStyle(
        fontSize: 40,
      ),
      headline3: TextStyle(
        fontSize: 33,
      ),
      headline4: TextStyle(
        fontSize: 28,
      ),
      headline5: TextStyle(
        fontSize: 23,
      ),
      headline6: TextStyle(
        fontSize: 19,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
      ),
      bodyText2: TextStyle(
        fontSize: 12,
      ));

  const inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: secondaryColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: dangerColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  );

  final buttonTheme = ButtonThemeData(
      colorScheme: const ColorScheme.light(primary: primaryColor),
      buttonColor: primaryColor,
      splashColor: primaryColorLight,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));

  return ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,
    highlightColor: secondaryColor,
    secondaryHeaderColor: secondaryColorDark,
    disabledColor: disabledColor,
    dividerColor: dividerColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      primaryContainer: primaryColorDark,
      error: dangerColor,
      secondary: secondaryColor,
      secondaryContainer: secondaryColorLight,
      background: backgroundColor,
    ),
    backgroundColor: backgroundColor,
    fontFamily: 'Roboto-Regular',
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
    buttonTheme: buttonTheme,
  );
}
