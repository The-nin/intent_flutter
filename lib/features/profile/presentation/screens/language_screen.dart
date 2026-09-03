import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.profile.language.tr())),

      body: Column(
        children: [
          ListTile(
            title: const Text("English"),
            trailing: currentLocale.languageCode == 'en'
                ? const Icon(Icons.check)
                : null,
            onTap: () async {
              await context.setLocale(const Locale('en'));

              if (context.mounted) {
                context.pop();
              }
            },
          ),

          ListTile(
            title: const Text("Tiếng Việt"),
            trailing: currentLocale.languageCode == 'vi'
                ? const Icon(Icons.check)
                : null,
            onTap: () async {
              await context.setLocale(const Locale('vi'));

              if (context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
