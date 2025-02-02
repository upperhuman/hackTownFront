import 'package:flutter/material.dart';
import 'settings_buttons.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < constraints.maxHeight) {
          return const MobileSettingsPage();
        } else {
          return const DesktopSettingsPage();
        }
      },
    );
  }
}

class DesktopSettingsPage extends StatefulWidget {
  const DesktopSettingsPage({super.key});

  @override
  State<DesktopSettingsPage> createState() => _DesktopSettingsPageState();
}

class _DesktopSettingsPageState extends State<DesktopSettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SettingsBackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 40,
              ),
            ),
            const Center(
              child: SettingsButtons(),
            ),
          ],
        ),
      ),
    );
  }
}

class MobileSettingsPage extends StatefulWidget {
  const MobileSettingsPage({super.key});

  @override
  State<MobileSettingsPage> createState() => _MobileSettingsPageState();
}

class _MobileSettingsPageState extends State<MobileSettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SettingsBackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 5,
              top: 25,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 35,
              ),
            ),
            const Center(
              child: SettingsButtons(),
            ),
          ],
        ),
      ),
    );
  }
}