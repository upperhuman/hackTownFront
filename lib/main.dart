import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/pages/main_pages/main_page.dart';
import 'package:flutter/material.dart';

final themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize localization
  await EasyLocalization.ensureInitialized();

  // Load environment variables

  const String BASE_URL = String.fromEnvironment('BASE_URL');
  const String GOOGLE_MAP_API = String.fromEnvironment('GOOGLE_MAP_API');

  if(BASE_URL.isEmpty || GOOGLE_MAP_API.isEmpty) {
    await dotenv.load(fileName: "assets/.env");
  }
  else {
    dotenv.load(mergeWith: {'BASE_URL': BASE_URL, 'GOOGLE_MAP_API': GOOGLE_MAP_API});
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('uk', 'UA'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp(),
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
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.white,
            actionTextColor: Colors.black,
            contentTextStyle: TextStyle(
              color: Colors.black
            )
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
            color: Colors.white
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
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
          ),
           iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.black,
            actionTextColor: Colors.white,
            contentTextStyle: TextStyle(
              color: Colors.white
            )
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
            color: Colors.black
          )
        ),
      home: MainPage(),
    );
    });
  }
}