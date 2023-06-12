import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';
import 'package:to_do_list/helpers/constants.dart';
import 'package:to_do_list/providers/task.dart';
import 'package:to_do_list/screens/main/main_screen.dart';
import 'package:to_do_list/screens/new_task/new_task_screen.dart';


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
  supportedLocales: const [ // English
    Locale('ru'), // Spanish
  ],
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: blueLight),
      ),
      home: const MainScreen(),
      routes: {
        MainScreen.routeName: (ctx) => const MainScreen(),
        NewTaskScreen.routeName: (ctx) => const NewTaskScreen(),
      },
    );
  }
}


