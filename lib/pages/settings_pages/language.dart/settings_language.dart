import 'package:flutter/material.dart';
import 'language_picker.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < constraints.maxHeight) {
          return const MobileLanguagePage();
        } else {
          return const DesktopLanguagePage();
        }
      },
    );
  }
}

class DesktopLanguagePage extends StatefulWidget {
  const DesktopLanguagePage({super.key});

  @override
  State<DesktopLanguagePage> createState() => _DesktopLanguagePageState();
}

class _DesktopLanguagePageState extends State<DesktopLanguagePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SettingsBackground2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 40,
              ),
            ),
            const Align(
              child: LanguageButtons(),
            ),
          ],
        ),
      ),
    );
  }
}

class MobileLanguagePage extends StatefulWidget {
  const MobileLanguagePage({super.key});

  @override
  State<MobileLanguagePage> createState() => _MobileLanguagePageState();
}

class _MobileLanguagePageState extends State<MobileLanguagePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SettingsBackground2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 5,
              top: 25,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 35,
              ),
            ),
            const Align(
              child: LanguageButtons(),
            ),
          ],
        ),
      ),
    );
  }
}