import 'package:hack_town_front/pages/route_page/route_buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../widgets/positionated_buttons.dart';
import '/widgets/bottom_navigation_panel.dart';
import '/widgets/navigation_panel.dart';
import 'package:flutter/material.dart';
import 'package:hack_town_front/dtos/event_route.dart';
import '/dtos/event_route.dart';

// Route page
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

// Route Page Desktop
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
          // Navigation panel for Desktop 
          const NavigationPanel(),
          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "route_page.choose".tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
              // Pass the routeData to RouteButtons
              //RouteButtons(routeData: widget.routeData?.first ?? EventRouteDTO()),
            ],
          ),
          // Back button
          PositionatedButtons(),
        ],
      ),
    );
  }
}


// Route Page Mobile
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
          // Main content
         Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //RouteButtons(),
              ],
            ),
          ),
          // Back button
          PositionatedButtons(),
        ],
      ),
      // Navigation panel for Mobile
      bottomNavigationBar: const BottomNavigationPanel(),
    );
  }
}