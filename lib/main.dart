import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '/pages/main_pages/main_page.dart';

final themeNotifier = ValueNotifier(ThemeMode.dark);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('uk', 'UA'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier, 
      builder: (context, value, child) {
      return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales, 
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'LocalLens',
        themeMode: value,
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.blue,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.grey[100],
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.white,
            actionTextColor: Colors.black,
            contentTextStyle: TextStyle(
              color: Colors.black
            )
          )
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.black,
            actionTextColor: Colors.white,
            contentTextStyle: TextStyle(
              color: Colors.white
            )
          )
        ),
      home: MainPage(),
    );
    });
  }
}