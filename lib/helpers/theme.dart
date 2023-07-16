import 'package:flutter/material.dart';
import 'package:to_do_list/helpers/constants.dart';

ThemeData lightTheme = ThemeData(
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: blueLight),
  textTheme: ThemeData().textTheme.copyWith(
        bodyLarge: const TextStyle(color: labelLightPrimary),
        bodySmall: const TextStyle(
          color: labelLightTertiary,
        ),
      ),
  cardTheme: const CardTheme().copyWith(color: backLightSecondary),
  appBarTheme: const AppBarTheme().copyWith(backgroundColor: backLightPrimary),
  dividerTheme: const DividerThemeData(color: supportLightSeparator),
  disabledColor: labelLightDisable,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: blueLight,
    secondary: greenLight,
    inversePrimary: backLightElevated,
    onSurface: labelLightPrimary,
    background: backLightPrimary,
    error: true? redLight : const Color(0xFF793cd8),
    surface: redLight,
  ),
  iconTheme: const IconThemeData(color: grayLight),
  shadowColor: supportLightOverlay,
  datePickerTheme: const DatePickerThemeData(
    rangePickerHeaderHeadlineStyle: TextStyle(color: labelLightPrimary),
    headerHeadlineStyle: TextStyle(color: labelLightTertiary),
    yearForegroundColor: MaterialStatePropertyAll(labelLightPrimary),
    todayBorder: BorderSide.none,
    backgroundColor: backLightSecondary,
    weekdayStyle: TextStyle(color: labelLightTertiary),
    headerBackgroundColor: blueLight,
    rangePickerSurfaceTintColor: labelLightPrimary,
  ),
);
ThemeData darkTheme = ThemeData(
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: blueDark),
  textTheme: ThemeData().textTheme.copyWith(
        bodyLarge: const TextStyle(color: labelDarkPrimary),
        bodySmall: const TextStyle(
          color: labelDarkTertiary,
        ),
      ),
  cardTheme: const CardTheme().copyWith(color: backDarkSecondary),
  appBarTheme: const AppBarTheme().copyWith(backgroundColor: backDarkPrimary),
  dividerTheme: const DividerThemeData(color: supportDarkSeparator),
  disabledColor: labelDarkDisable,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: blueDark,
    secondary: greenDark,
    inversePrimary: backDarkElevated,
    onSurface: labelDarkPrimary,
    background: backDarkPrimary,
    error: true? redDark : const Color(0xFF793cd8),
    surface: redDark,
  ),
  iconTheme: const IconThemeData(color: grayDark),
  shadowColor: supportDarkOverlay,
  datePickerTheme: const DatePickerThemeData(
    rangePickerHeaderHeadlineStyle: TextStyle(color: labelDarkPrimary),
    headerHeadlineStyle: TextStyle(color: labelDarkTertiary),
    yearForegroundColor: MaterialStatePropertyAll(labelDarkPrimary),
    todayBorder: BorderSide.none,
    backgroundColor: backDarkSecondary,
    weekdayStyle: TextStyle(color: labelDarkTertiary),
    headerBackgroundColor: blueDark,
    rangePickerSurfaceTintColor: labelDarkPrimary,
  ),
);
