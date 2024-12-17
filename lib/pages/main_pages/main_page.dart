import 'package:easy_localization/easy_localization.dart';
import '/pages/main_pages/user_profile_page.dart';
import '/widgets/bottom_navigation_panel.dart';
import '/widgets/search_mobile_bar.dart';
import 'package:http/http.dart' as http;
import '/widgets/navigation_panel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
  String selectedEventType = "test_page.dating".tr();
  int selectedNumberOfPeople = 1;
  String selectedBudget = "test_page.low_cost".tr();
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
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Center(
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
                            "test_page.dating".tr(),
                            "test_page.business_meet".tr(),
                            "test_page.walk".tr(),
                            "test_page.hang_out".tr()
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
                          buildDropdown("test_page.budget".tr(), [
                             "test_page.low_cost".tr(),
                             "test_page.medium_cost".tr(),
                             "test_page.high_cost".tr()
                          ], selectedBudget, (value) {
                            setState(() {
                              selectedBudget = value!;
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown(String label, List<String> items, String selectedValue, ValueChanged<String?> onChanged) {
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue,
                  isExpanded: true,
                  onChanged: onChanged,
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  style: const TextStyle(color: Colors.black),
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ),
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
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ElevatedButton(
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: Colors.black,
                        timePickerTheme: const TimePickerThemeData(
                          backgroundColor: Colors.white, // Фон часов
                          hourMinuteColor: Colors.black12,
                          hourMinuteTextColor: Colors.black,
                          dialHandColor: Colors.black12,
                          dialTextColor: Colors.black,
                        ),
                        colorScheme: const ColorScheme.light(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
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
              child: Text(
                selectedTime.format(context),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFindButton() {
    return SizedBox(
      width: 400,
      child: ElevatedButton(
        onPressed: () {
          print({
            'eventType': selectedEventType,
            'numberOfPeople': selectedNumberOfPeople,
            'budget': selectedBudget,
            'duration': selectedDuration.format(context),
          });
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
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
      final request = await client.postUrl(
          Uri.parse('https://385238ef-6c7a-41a1-9893-a886d9fbee7f.mock.pstmn.io/'));
      request.headers.set('Content-Type', 'application/json; charset=UTF-8');
      request.write(jsonEncode(data));
      final response = await request.close();

      // Log the request and response
      print('Request sent to: ${request.uri}');
      print('Response status: ${response.statusCode}');

      // Handle redirects
      if (response.statusCode == 307) {
        final redirectUrl = response.headers.value('location');
        if (redirectUrl != null) {
          final redirectRequest = await client.postUrl(Uri.parse(redirectUrl));
          redirectRequest.headers.set('Content-Type', 'application/json; charset=UTF-8');
          redirectRequest.write(jsonEncode(data));
          final redirectResponse = await redirectRequest.close();
          return await convertHttpClientResponseToHttpResponse(redirectResponse);
        }
      }

      return await convertHttpClientResponseToHttpResponse(response);
    } finally {
      client.close();
    }
  }

  Future<http.Response> convertHttpClientResponseToHttpResponse(HttpClientResponse response) async {
    final responseData = await response.transform(utf8.decoder).join();
    final headers = <String, String>{};
    response.headers.forEach((name, values) {
      headers[name] = values.join(', ');
    });
    return http.Response(responseData, response.statusCode, headers: headers);
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
      appBar: AppBar(
        title: const SearchBarMobile(),
        automaticallyImplyLeading: false,
      ),
      body: Text('data'),
      bottomNavigationBar: const BottomNavigationPanel(),
    );
  }
}