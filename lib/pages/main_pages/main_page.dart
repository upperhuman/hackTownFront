import 'package:easy_localization/easy_localization.dart';
import '/pages/main_pages/user_profile_page.dart';
import '/widgets/bottom_navigation_panel.dart';
import '/widgets/search_mobile_bar.dart';
import 'package:http/http.dart' as http;
import '/widgets/navigation_panel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hack_town_front/dtos/event_route.dart';

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
  bool isKeyboardInput = false; // Переменная для отслеживания текущего режима (клавиатура/голос)

  // Параметры, которые ранее использовались на TestPage
  String selectedEventType = 'Dating';
  int selectedNumberOfPeople = 1;
  int selectedBudget = 1000;
  TimeOfDay selectedDuration = TimeOfDay(hour: 1, minute: 0);

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
                  buildDropdown("test_page.event_type".tr(), [
                    'Dating',
                    'Business meet',
                    'Walk',
                    'Hang out'
                  ], selectedEventType, (value) {
                    setState(() {
                      selectedEventType = value!;
                    });
                  }),
                  const SizedBox(height: 10),
                  buildDropdown("test_page.number_of_people".tr(),
                      List.generate(100, (index) => (index + 1).toString()),
                      selectedNumberOfPeople.toString(), (value) {
                        setState(() {
                          selectedNumberOfPeople = int.parse(value!);
                        });
                      }),
                  const SizedBox(height: 10),
                  buildDropdown("test_page.budget".tr(),
                    List.generate(10000, (index) => (index + 1).toString()),
                      selectedBudget.toString(), (value) {
                    setState(() {
                      selectedBudget = int.parse(value!);
                    });
                  }),
                  const SizedBox(height: 10),
                  buildTimePicker("test_page.duration".tr(), selectedDuration, (value) {
                    setState(() {
                      selectedDuration = value!;
                    });
                  }),
                  const SizedBox(height: 20),
                  buildFindButton(),
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

  Widget buildDropdown(String label, List<String> items, String selectedValue, ValueChanged<String?> onChanged) {
    return SizedBox(
      width: 400, // Фиксированная ширина для всех полей ввода
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: DropdownButton<String>(
              value: selectedValue,
              onChanged: onChanged,
              isExpanded: true,
              underline: Container(),
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimePicker(String label, TimeOfDay selectedTime, ValueChanged<TimeOfDay?> onChanged) {
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 5),
          Container(
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ElevatedButton(
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (picked != null && picked != selectedTime) {
                  onChanged(picked);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Text(selectedTime.format(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFindButton() {
    return SizedBox(
      width: 400, // Fixed width for the button
      child: ElevatedButton(
        onPressed: () async {
          // Collect the data
          final data = {
            'userId': 1,
            'eventType': selectedEventType,
            'peopleCount': selectedNumberOfPeople,
            'eventTime': selectedDuration.format(context),
            'costTier': selectedBudget,
          };

          // Log the collected data
          print('Collected data: $data');
          final response = await sendDataToServer(data);
          Map<String, dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));

          // List<dynamic> list = responseData[""];
          // List<EventRouteDTO> routes = [];
          //
          // for(var item in list){
          //   Map<String, dynamic> map = item;
          //   routes.add(EventRouteDTO.fromMap(map));
          // }
          EventRouteDTO route = EventRouteDTO.fromMap(responseData);
          print("---");
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 40.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.grey,
        ),
        child: Text(
          "test_page.find".tr(),
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Future<http.Response> sendDataToServer(Map<String, dynamic> data) async {
    final client = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;


    try {

      var request = await http.post(
        Uri.parse('${dotenv.env["BASE_URL"]!}/api/UserRequests'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'}
        );

      // final request = await client.postUrl(
      //     Uri.parse('${dotenv.env["BASE_URL"]!}/api/UserRequests'));
      // request.headers.set('Content-Type', 'application/json; charset=UTF-8');
      // request.write(jsonEncode(data));
      // final response = await request.close();

      return request;
    } finally {
      client.close();
    }
  }

  // Future<http.Response> convertHttpClientResponseToHttpResponse(HttpClientResponse response) async {
  //   final responseData = await response.transform(utf8.decoder).join();
  //   final headers = <String, String>{};
  //   response.headers.forEach((name, values) {
  //     headers[name] = values.join(', ');
  //   });
  //   return http.Response(responseData, response.statusCode, headers: headers);
  // }
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
      appBar: AppBar(
        title: const SearchBarMobile(),
        automaticallyImplyLeading: false,
      ),
      body: Text('data'),
      bottomNavigationBar: const BottomNavigationPanel(),
    );
  }
}
