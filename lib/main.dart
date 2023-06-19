import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';
import 'package:to_do_list/helpers/constants.dart';
import 'package:to_do_list/providers/task.dart';
import 'package:to_do_list/screens/main/main_screen.dart';
import 'package:to_do_list/screens/save_task/save_task_screen.dart';

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Tasks(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        // English
        Locale('ru'), // Spanish
      ],
      theme: ThemeData(
        // ignore: deprecated_member_use
        backgroundColor: backLightPrimary,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: blueLight),
        textTheme: ThemeData().textTheme.copyWith(
            bodyLarge: const TextStyle(color: labelLightPrimary),
            bodySmall: const TextStyle(
              color: labelLightTertiary,
            ),),
        cardTheme: const CardTheme().copyWith(color: backLightSecondary),
        appBarTheme:
            const AppBarTheme().copyWith(backgroundColor: backLightPrimary),
        dividerTheme: const DividerThemeData(color: supportLightSeparator),
        disabledColor: labelLightDisable,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: blueLight,
          secondary: greenLight,
          inversePrimary: backLightElevated,
          onSurface: labelLightPrimary,
        ),
        iconTheme: const IconThemeData(color: grayLight),
        // ignore: deprecated_member_use
        errorColor: redLight,
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
      ),
      darkTheme: ThemeData(
        // ignore: deprecated_member_use
        backgroundColor: backDarkPrimary,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: blueDark),
        textTheme: ThemeData().textTheme.copyWith(
              bodyLarge: const TextStyle(color: labelDarkPrimary),
              bodySmall: const TextStyle(
                color: labelDarkTertiary,
              ),
            ),
        cardTheme: const CardTheme().copyWith(color: backDarkSecondary),
        appBarTheme:
            const AppBarTheme().copyWith(backgroundColor: backDarkPrimary),
        dividerTheme: const DividerThemeData(color: supportDarkSeparator),
        disabledColor: labelDarkDisable,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: blueDark,
          secondary: greenDark,
          inversePrimary: backDarkElevated,
          onSurface: labelDarkPrimary,
        ),
        iconTheme: const IconThemeData(color: grayDark),
        // ignore: deprecated_member_use
        errorColor: redDark,
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
      ),
      themeMode: ThemeMode.system,
      home: const MainScreen(),
      routes: {
        MainScreen.routeName: (ctx) => const MainScreen(),
        NewTaskScreen.routeName: (ctx) => NewTaskScreen(),
      },
    );
  }
}
