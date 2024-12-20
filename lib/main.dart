import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import '/pages/main_pages/main_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final themeNotifier = ValueNotifier(ThemeMode.light);

class IFramePage extends StatelessWidget {
  final String url;
  const IFramePage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IFrame Viewer"),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

void main() async {
  // Ensure Flutter bindings are initialized first
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize localization
  await EasyLocalization.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: "assets/.env");
  
  // Initialize WebView platform
  if (WebViewPlatform.instance == null) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      WebViewPlatform.instance = AndroidWebViewPlatform();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      WebViewPlatform.instance = CupertinoWebViewPlatform();
    }
  }
  
  HttpOverrides.global = new DevHttpOverrides();


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
            color: Colors.white, // Light theme icon color
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

class ThemedImageWidget extends StatelessWidget {
  const ThemedImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, child) {
        final imagePath = themeMode == ThemeMode.dark
            ? 'assets/images/dark_theme_image.png'
            : 'assets/images/light_theme_image.png';

        return Image.asset(imagePath);
      },
    );
  }
}

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(final SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
