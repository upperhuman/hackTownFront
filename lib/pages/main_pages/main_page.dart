import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hack_town_front/dtos/event_route.dart';
import '../../main.dart';
import '../../widgets/bottom_navigation_panel.dart';
import 'main_page_widgets.dart';
import '/widgets/navigation_panel.dart';
import 'package:flutter/material.dart';
import '/widgets/voice_input.dart';


class MainPage extends StatelessWidget {
  MainPage({super.key});
  final String? baseUrl = BASE_URL;

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
  int selectedBudget = 0;
  TimeOfDay selectedDuration = TimeOfDay(hour: 1, minute: 0);
  Position? userLocation;

  List<Map<String, String>> eventTypesData = [
    {"id": "dating", "label": "test_page.dating".tr()},
    {"id": "business_meet", "label": "test_page.business_meet".tr()},
    {"id": "walk", "label": "test_page.walk".tr()},
    {"id": "hang_out", "label": "test_page.hang_out".tr()},
  ];

  List<EventRouteDTO> routes = [];

  final _budgetItems = List.generate(21, (index) => (index * 1000).toString());
  final _peopleItems = List.generate(20, (index) => (index + 1).toString());

  @override
  void initState() {
    super.initState();
    _requestUserLocation();
  }

  Future<void> _requestUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location permissions are permanently denied. We cannot request permissions.',
        );
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        userLocation = position;
      });

      if (userLocation != null) {
        print('User location: $userLocation');
      }
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NavigationPanel(),
          /*Positioned(
            right: 0,
            /*child: IconButton(
              icon: Icon(Icons.account_circle_outlined,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfilePage()),
                );
              },
              iconSize: 45,
            ),*/
          ),*/
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
                          icon: const Icon(Icons.arrow_drop_down),
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
                      'userLocation': userLocation != null
                          ? '${userLocation!.latitude}, ${userLocation!.longitude}'
                          : 'Unknown',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VoiceInputScreen()),
                      );
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
          /*Positioned(
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
          ),*/
          Center(
            child: SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "test_page.greeting".tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: Icon(Icons.mic_none_outlined, color: Theme.of(context).iconTheme.color),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VoiceInputScreen()),
                      );
                    },
                    iconSize: 80,
                  ),
                  Text(
                    "test_page.voice".tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            )
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationPanel(),
    );
  }
}