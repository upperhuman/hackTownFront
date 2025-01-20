import 'package:easy_localization/easy_localization.dart';
import 'package:hack_town_front/dtos/event_route.dart';
import '/widgets/bottom_navigation_panel.dart';
import '../main_pages/user_profile_page.dart';
import '../../widgets/route_buttons.dart';
import '/widgets/navigation_panel.dart';
import 'package:flutter/material.dart';

class RoutePage extends StatelessWidget {
  final List<EventRouteDTO>? routeData;

  const RoutePage({
    super.key,
    this.routeData,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < constraints.maxHeight) {
          return  MobileRoutePage(routeData: routeData);
        } else {
          return  DesktopRoutePage(routeData: routeData);
        }
      },
    );
  }
}

class DesktopRoutePage extends StatefulWidget {
  final List<EventRouteDTO>? routeData;
  const DesktopRoutePage({super.key,this.routeData,});

  @override
  State<DesktopRoutePage> createState() => _DesktopRoutePageState();
}

class _DesktopRoutePageState extends State<DesktopRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavigationPanel(),
          Positioned(
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 45,
            ),
          ),
          // User profile button
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(Icons.account_circle_outlined, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const UserProfilePage()),
                );
              },
              iconSize: 45,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "route_page.choose".tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MobileRoutePage extends StatefulWidget {
  final List<EventRouteDTO>? routeData;
  const MobileRoutePage({super.key, this.routeData,});

  @override
  State<MobileRoutePage> createState() => _MobileRoutePageState();
}

class _MobileRoutePageState extends State<MobileRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RouteButtons(widget.routeData),
            ],
          ),
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
          Positioned(
            right: 5,
            top: 25,
            child: IconButton(
              icon: Icon(Icons.account_circle_outlined,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserProfilePage()),
                );
              },
              iconSize: 35,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationPanel(),
    );
  }
}
