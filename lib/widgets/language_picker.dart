import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class LanguageButtons extends StatefulWidget {
  const LanguageButtons({super.key});

  @override
  State<LanguageButtons> createState() => _LanguageButtonsState();
}

class _LanguageButtonsState extends State<LanguageButtons> {
  final List<Map<String, dynamic>> languages = [
    {'locale': Locale('uk', 'UA'), 'name': '🇺🇦 Українська'},
    {'locale': Locale('en', 'US'), 'name': '🇺🇸 English'},
  ];

  Locale? selectedLocale;

  @override
  Widget build(BuildContext context) {
    selectedLocale = languages.firstWhere(
      (lang) => lang['locale'] == context.locale,
      orElse: () => languages[0],
    )['locale'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.language, size: 24, color: Colors.black),
          const SizedBox(height: 8),
          Text(
            "select_a_language".tr(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30),
          DropdownButtonFormField2<Locale>(
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
            items: languages
                .map((lang) => DropdownMenuItem<Locale>(
                      value: lang['locale'],
                      child: Text(
                        lang['name'],
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ))
                .toList(),
            value: selectedLocale,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedLocale = value;
                  context.setLocale(value);
                });
              }
            },
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          )
        ],
      ),
    );
  }
}