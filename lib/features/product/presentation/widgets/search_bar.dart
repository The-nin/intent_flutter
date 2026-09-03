import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const CustomSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: colors.onSurfaceVariant),
          hintText: LocaleKeys.homeScreen.searchForProducts.tr(),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
