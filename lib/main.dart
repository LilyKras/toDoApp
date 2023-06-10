import 'package:flutter/material.dart';
import 'package:to_do_list/helpers/constants.dart';
import 'package:to_do_list/screens/main/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColorLight: backLightPrimary,
        primaryColorDark: backDarkPrimary,
        useMaterial3: true,
      ),
      home: const MainScreen(),
      routes: {
        MainScreen.routeName: (ctx) => const MainScreen(),
        // NewTaskScreen.routeName: (ctx) => const NewTaskScreen(),
      },
    );
  }
}
