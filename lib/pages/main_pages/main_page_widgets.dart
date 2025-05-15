import 'package:hack_town_front/pages/route_page/route_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hack_town_front/dtos/event_route.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../main.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
              border: Border.all(color: Colors.grey),
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
}

class TimePickerWidget extends StatelessWidget {
  final String label;
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay?> onChanged;

  const TimePickerWidget({
    super.key,
    required this.label,
    required this.selectedTime,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
              borderRadius: BorderRadius.circular(15),
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
                          backgroundColor: Colors.white,
                          hourMinuteColor: Colors.black12,
                          hourMinuteTextColor: Colors.black,
                          dialHandColor: Colors.black12,
                          dialTextColor: Colors.black,
                          dayPeriodColor: Colors.black12,
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
}

class FindButton extends StatelessWidget {
  final Map<String, dynamic> data;
  final Future<http.Response> Function(Map<String, dynamic>) sendDataToServer;

  const FindButton({
    super.key,
    required this.data,
    required this.sendDataToServer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ElevatedButton(
        onPressed: () async {
          // Log the collected data
          print('Collected data: $data');

          // Show loading dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const Center(
                child: SpinKitFadingCircle(
                  size: 150,
                  color: Colors.white,
                ),
              );
            },
          );

          try {
            final response = await sendDataToServer(data);

            if (response.statusCode == 500) {
              throw Exception('server_error');
            }

            Map<String, dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));


            List<dynamic> list = responseData["routes"];
            List<EventRouteDTO> routes = [];
            for (var item in list) {
              Map<String, dynamic> map = item;
              routes.add(EventRouteDTO.fromMap(map));
            }

            // Dismiss the loading dialog
            Navigator.of(context, rootNavigator: true).pop();

            // Navigate to the RoutePage
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RoutePage(routeData: routes)),
            );

          } catch (e) {
            // Handle error and dismiss the loading dialog
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $e')),
            );

            String errorMessage = e.toString().contains('server_error')
                ? 'Спробуйте трохи пізніше'
                : 'Error: $e';
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Error"),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("ОК"),
                  ),
                ],
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        child: Text(
          "test_page.find".tr(),
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}

Future<http.Response> sendDataToServer(Map<String, dynamic> data) async {
  try {

    var request = await http.post(
        Uri.parse('$BASE_URL/api/UserRequests'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'}
    );

    // final request = await client.postUrl(
    //     Uri.parse('${dotenv.env["BASE_URL"]!}/api/UserRequests'));
    // request.headers.set('Content-Type', 'application/json; charset=UTF-8');
    // request.write(jsonEncode(data));
    // final response = await request.close();

    return request;
  } catch (e) {
    throw Exception('Error: $e');
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