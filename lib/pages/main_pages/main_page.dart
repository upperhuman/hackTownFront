import 'package:easy_localization/easy_localization.dart';
import 'package:hack_town_front/dtos/event_route.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/pages/main_pages/user_profile_page.dart';
import '/widgets/main_page_widgets.dart';
import '/widgets/navigation_panel.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final String? baseUrl = dotenv.env["BASE_URL"];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < constraints.maxHeight) {
          return const MobileMainPage();
        } else {
          return const DesktopMainPage();
        }
      },
    );
  }
}

class DesktopMainPage extends StatefulWidget {
  const DesktopMainPage({super.key});

  @override
  State<DesktopMainPage> createState() => _DesktopMainPageState();
}

class _DesktopMainPageState extends State<DesktopMainPage> {
  bool isKeyboardInput = false;
  String selectedEventType = "dating";
  int selectedNumberOfPeople = 1;
  int selectedBudget = 10;
  TimeOfDay selectedDuration = TimeOfDay(hour: 1, minute: 0);

  List<Map<String, String>> eventTypesData = [
    {"id": "dating", "label": "test_page.dating".tr()},
    {"id": "business_meet", "label": "test_page.business_meet".tr()},
    {"id": "walk", "label": "test_page.walk".tr()},
    {"id": "hang_out", "label": "test_page.hang_out".tr()},
  ];

  List<EventRouteDTO> routes = [];

  final _budgetItems = List.generate(100, (index) => (index * 10).toString());
  final _peopleItems = List.generate(100, (index) => (index + 1).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const NavigationPanel(),
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(Icons.account_circle_outlined,
                  color: Theme.of(context).iconTheme.color),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "test_page.greeting".tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 400,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedEventType,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedEventType = newValue!;
                            });
                          },
                          items: eventTypesData.map<DropdownMenuItem<String>>((item) {
                            return DropdownMenuItem<String>(
                              value: item["id"],
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(item["label"]!),
                              ),
                            );
                          }).toList(),
                          icon: Icon(Icons.arrow_drop_down),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          style: const TextStyle(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomDropdown(
                    label: "test_page.number_of_people".tr(),
                    items: _peopleItems,
                    selectedValue: selectedNumberOfPeople.toString(),
                    onChanged: (value) {
                      setState(() {
                        selectedNumberOfPeople = int.parse(value!);
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomDropdown(
                    label: "test_page.budget".tr(),
                    items: _budgetItems,
                    selectedValue: selectedBudget.toString(),
                    onChanged: (value) {
                      setState(() {
                        selectedBudget = int.parse(value!);
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TimePickerWidget(
                    label: "test_page.duration".tr(),
                    selectedTime: selectedDuration,
                    onChanged: (value) {
                      setState(() {
                        selectedDuration = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  FindButton(
                    data: {
                      'userId': 1,
                      'eventType': selectedEventType,
                      'peopleCount': selectedNumberOfPeople,
                      'eventTime': selectedDuration.format(context),
                      'costTier': selectedBudget,
                    },
                    sendDataToServer: sendDataToServer,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "test_page.or".tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: Icon(Icons.mic_none_outlined, color: Theme.of(context).iconTheme.color),
                    onPressed: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ...()),
                      );*/
                    },
                    iconSize: 100,
                  ),
                  Text(
                    "test_page.voice".tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileMainPage extends StatefulWidget {
  const MobileMainPage({super.key});

  @override
  State<MobileMainPage> createState() => _MobileMainPageState();
}

class _MobileMainPageState extends State<MobileMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
        ],
      ),
    );
  }
}