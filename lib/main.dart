import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/firebase_options.dart';
import 'package:to_do_list/helpers/logger.dart';

import 'package:to_do_list/helpers/theme.dart';
import 'package:to_do_list/ui/screens/main/main_screen.dart';
import 'package:to_do_list/ui/screens/save_task/save_task_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future <void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails){
    log('warning', 'Caught error in FlutterError.onError');
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  PlatformDispatcher.instance.onError=(error, stack){
    log('warning', 'Caught error in PlatformDispatcher.onError');
    FirebaseCrashlytics.instance.recordError(error, stack, fatal:true );
    return true;
  };


}
Future<void> main() async {
_init();

  runApp(
    const ProviderScope(
      child: MyApp(),
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
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ru'), // Russian
      ],
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const MainScreen(),
      routes: {
        MainScreen.routeName: (ctx) => const MainScreen(),
        NewTaskScreen.routeName: (ctx) => const NewTaskScreen(),
      },
    );
  }
}
