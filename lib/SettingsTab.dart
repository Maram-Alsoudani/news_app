import 'package:flutter/material.dart';
import 'package:news_app/providers/LanguageProvider.dart';
import 'package:provider/provider.dart';

import 'AppColors.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LanguageProvider>(context);
    String selectedLanguage = provider.currentLanguage;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Language",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.black, fontSize: 19),
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButtonFormField<String>(
            value: selectedLanguage,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            items: [
              "ar",
              "en",
              "de",
              "es",
              "fr",
              "he",
              "it",
              "nl",
              "no",
              "pt",
              "ru",
              "sv",
              "ud",
              "zh"
            ].map((String language) {
              return DropdownMenuItem(
                  value: language,
                  child: Text(
                    language,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: language == selectedLanguage
                            ? AppColors.primaryColor
                            : AppColors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                provider.setLanguage(newValue!);
              });
            },
          )
        ],
      ),
    );
  }
}
